{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE TupleSections #-}

-- | Type checker for C--, producing typed syntax from ASTs.

module TypeChecker where

import Control.Applicative
import Control.Monad
import Control.Monad.Except
import Control.Monad.Reader
import Control.Monad.State

import Data.Functor
import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map
import qualified Data.Set as Set

import CMM.Abs
import CMM.Print (printTree)
import CMM.ErrM  (Err(Ok, Bad))

import qualified Annotated as A

-- | Entry point of type checker.

-- Different types --
type Env = (Sig, [Context])
type Sig = Map String ([Type], Type)
type Context = Map String Type


predefFunc = [("readInt",([], Tint)),
              ("readDouble",([], Tdouble)), 
              ("printDouble", ([Tdouble], Tvoid)),
              ("printInt", ([Tint], Tvoid))]

stringId :: Id -> String
stringId (Id s) = s

stringIds :: [Id] -> [String]
stringIds [] = []
stringIds ((Id s):ids) = s:(stringIds ids)

typecheck :: Program -> Err A.Program
typecheck (PDefs []) = fail $ "Empty program"
typecheck (PDefs defs) = checkDefs (Map.fromList predefFunc, []) defs >>= 
                                          \edefs -> return (A.PDefs edefs)

checkDefs :: Env -> [Def] -> Err [A.Def]
checkDefs env []                                          = checkMain env
checkDefs env deffar@((def@(DFun typ id args stms)):defs) =
  if elem (stringId id) (fromDefs defs) || (elem (stringId id ) ["readInt", "readDouble", "printDouble","printInt"]) then
    fail $ "Overloading is not permitted " 
  else do
    env1 <- buildSig env deffar
    (env',edef) <- checkDef env1 def
    (edfs) <- checkDefs env' defs
    return (edef:edfs)

checkDef :: Env -> Def -> Err (Env, A.Def)
checkDef (sig, xs) (DFun typ id args stms) = do
  checkArgs args
  let theArgs = fromArgs args
  let env' = (sig, f (fromArgsId args) Map.empty : xs)
  ((s, c:cs), astms) <- checkStms env' id stms
  return ((s, cs), A.DFun typ id args astms)

buildSig :: Env -> [Def] -> Err Env
buildSig env [] = return env
buildSig (sig,con) ((DFun typ id args stms):ds) = do
  let theArgs = fromArgs args
  let sig' = Map.insert (stringId id) (theArgs, typ) sig
  buildSig (sig',con) ds

f :: [(String, Type)] -> Context -> Context
f [] c = c
f ((s, t) : xs) c = f xs $ Map.insert s t c

fromArgs :: [Arg] -> [Type]
fromArgs [] = []
fromArgs ((ADecl typ id):args) = typ : fromArgs args

fromArgsId :: [Arg] -> [(String, Type)]
fromArgsId [] = []
fromArgsId ((ADecl typ id):args) = (stringId id, typ):fromArgsId args

checkMain :: Env -> Err [A.Def]
checkMain env = do 
  saker <- lookupFunc env "main"
  case saker of
    ([], Tint) -> return []
    _          -> fail $ "Main is not present or is ill-typed" 

fromDefs :: [Def] -> [String]
fromDefs [] = []
fromDefs ((DFun typ id args stms):defs) = (stringId id):(fromDefs defs)

checkArgs :: [Arg] -> Err ()
checkArgs []         = return ()
checkArgs ((ADecl typ id):args) =
  if typ == Tvoid || elem ((stringId id), typ) (fromArgsId args) then
    fail $ "The arguments are wrong"
  else
    return ()

lookupVar :: Env -> String -> Err Type
lookupVar env@(sig,xs) id = do 
  let types = (filter (\a -> a /= Nothing) (map (Map.lookup id) xs))
  case types of 
    []  -> do
      let types2 = Map.lookup id sig
      case types2 of 
        Nothing -> fail $ "Variable was not found " ++ printTree id
        Just (a:as,b) -> return a
    (Just typ:types) -> return typ

lookupFunc :: Env -> String -> Err ([Type], Type)
lookupFunc (a, _) id = let typ = Map.lookup id a
    in case typ of
        Nothing  -> fail $ " The function was not found"
        Just typ -> return typ

updateVar :: Env -> String -> Type -> Err Env
updateVar env@(_, []) id typ = fail $ "The type " ++ printTree id ++ " does not match the type " ++ printTree typ
updateVar env@(sig, x:xs) id typ = let typ2 = Map.lookup id x
        in case typ2 of
            Nothing -> fail $ ""
            Just typ2 -> updateVar (sig, xs) id typ

updateVars :: Env -> [String] -> Type -> Err Env
updateVars env [] _ = return env
updateVars env (id:ids) typ = do env' <- updateVar env id typ
                                 updateVars env' ids typ 
declVar :: Env -> [String] -> Type -> Err Env 
declVar env@(sig,c:context) ids typ =
  if typ == Tvoid then
    fail $ "Type void is not allowed for variables "
  else do
    let check = Map.lookup (head ids) c    
    case check of
      Nothing ->    return $ (sig, ((Map.insert (head ids) typ c):context))
      Just check -> fail $ "Variable already exists " ++ (printTree $ head ids)

declVars :: Env -> [String] -> Type -> Err Env
declVars env [] typ = return env
declVars env (id:ids) typ = declVar env [id] typ >>= (\e -> declVars e ids typ)  

checkStm :: Env -> Id -> Stm -> Err (Env, A.Stm)
checkStm env@(sig,cs) id stm = case stm of
  SExp exp  -> do
    (typ, ex) <- inferExp env exp
    return (env, A.SExp typ ex)
  SDecl typ ids  -> do
    env' <- declVars env (stringIds ids) typ
    return (env', A.SDecl typ ids)
  SInit typ id exp -> do
    env' <- declVar env [stringId id] typ
    (t, ex) <- checkExp env' typ exp
    return (env', A.SInit t id ex )           
  SWhile exp stm  -> do
    (t, ex) <- checkExp env Tbool exp
    ((sig1, c:cs), sd) <- checkStm (sig, Map.empty:cs) id stm
    return ((sig1, cs), A.SWhile ex sd)
    
  SReturn exp -> do 
    (typ, ex) <- inferExp env exp
    (_, typ1) <- lookupFunc env $ stringId id 
    if (typ == typ1)
       then 
        return (env, A.SReturn typ ex)
    else
        fail $ "The function type " ++ printTree typ1 ++ " does not match " ++ printTree typ
  SBlock stm -> do
    ((sig,c:cs), astms) <- checkStms (sig,Map.empty:cs) id stm
    return ((sig,cs), A.SBlock astms)
  SIfElse exp stm0 stm1 -> do
    (t, ex) <- checkExp env Tbool exp
    (env', astm) <- checkStm (sig, Map.empty:cs) id stm0
    ((sig,c:cs), astm1) <- checkStm (sig, Map.empty:cs) id stm1
    return ((sig, cs), A.SIfElse ex astm astm1)

checkStms :: Env -> Id -> [Stm] -> Err (Env, [A.Stm])
checkStms env id stms = case stms of 
                [] -> return (env, [])
                x:xs -> do 
                          (env', astm) <- checkStm env id x
                          (e, list) <- checkStms env' id xs
                          return (env' ,(astm:list))

checkExp :: Env -> Type -> Exp -> Err (Type, A.Exp)
checkExp env typ exp = do 
    (typ2, ex) <- inferExp env exp
    if(typ2 == typ || elem typ [Tdouble] && (elem typ2 [Tint] || elem typ2 [Tdouble])) then 
      return (typ, ex)
    else 
        fail $ "type of " ++ printTree exp ++
               " expected " ++ printTree typ ++
               " but found" ++ printTree typ2

inferExp :: Env -> Exp -> Err (Type, A.Exp)
inferExp env x = case x of
  ETrue      -> return (Tbool, A.ETrue)
  EFalse     -> return (Tbool, A.EFalse)
  EInt n     -> return (Tint, A.EInt n)
  EDouble n  -> return (Tdouble, A.EDouble n)
      
  EId id     -> do
    t <- lookupVar env $ stringId id 
    return (t, A.EId id)
  EPIncr id  -> do
    t <- inferNumeric env (EId id)
    return (t, A.EPIncr id)
  EPDecr id  -> do
    t <- inferNumeric env (EId id)
    return (t, A.EPDecr id)
  EIncr id   -> do
    t <- inferNumeric env (EId id)
    return (t, A.EIncr id)
  EDecr id   -> do
    t <- inferNumeric env (EId id)
    return (t, A.EDecr id)
  EAnd exp0 exp1 -> do
    (t, e, e1) <- inferNumericBin env exp0 exp1 [Tbool] "l"
    return (t, A.EAnd e e1)
  EOr exp0 exp1 -> do
    (t, exp, exp') <- inferNumericBin env exp0 exp1 [Tbool] "l"
    return (t, A.EOr exp exp')
    
  EAss id exp -> do
    (idType, d) <- inferExp env (EId id)
    (expType, dd) <- inferExp env exp
    if (elem expType [Tint, Tdouble] && elem idType [Tdouble]) || 
       (elem expType [Tint] && elem idType [Tint, Tdouble] || 
        elem idType [Tbool] && elem expType [Tbool]) then
      return (idType, A.EAss id dd)
    else
      fail $ "Wrong type of variable and assigned value " ++ printTree expType ++ " id of type " ++ printTree idType
      
      
      
  ECall id exps -> do
    argtypes <- mapM (inferExp env) exps
    let lista = fmap (\ (typ, _) -> typ) argtypes
    let lista2 = fmap (\ (_, aexp) -> aexp) argtypes
    (args,rtype) <- lookupFunc env $ stringId id 
    if (args == lista || (elem Tdouble args && (elem Tdouble lista || elem Tint lista)) && (length args) == (length lista)) then
      return (rtype, A.ECall id lista2)
    else
      fail $ "Fail, wrong variable type for function arguments: " ++ printTree lista ++ "    args: " ++ printTree lista
  EMul exp0 exp1 -> do 
    (t, ex, ex1) <- inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
    return (t, A.EMul t ex ex1)
  EDiv exp0 exp1 -> do
    (t, ex, ex1) <- inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
    return (t, A.EDiv t ex ex1)
  EAdd exp0 exp1 -> do
    (t, ex, ex1) <- inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
    return (t, A.EAdd t ex ex1)
  ESub exp0 exp1 -> do
    (t, ex, ex1) <- inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
    return (t, A.ESub t ex ex1) 
  ELt exp0 exp1 -> do
    (t, ex, ex1) <- inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
    return (Tbool, A.ELt t ex ex1)
  EGt exp0 exp1 -> do
    (t, ex, ex1) <- inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
    return (Tbool, A.EGt t ex ex1)
  ELEq exp0 exp1 -> do
    (t, ex, ex1) <- inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
    return (Tbool, A.ELEq t ex ex1)
  EGEq exp0 exp1 -> do
    (t, ex, ex1) <- inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
    return (Tbool, A.EGEq t ex ex1)
  EEq exp0 exp1 -> do
    (t, ex, ex1) <- inferNumericBin env exp0 exp1 [Tint, Tdouble] "l"
    return (Tbool, A.EEq t ex ex1)
  ENEq exp0 exp1 -> do
    (t, ex, ex1) <- inferNumericBin env exp0 exp1 [Tint, Tdouble] "l"
    return (Tbool, A.ENEq t ex ex1)

inferNumeric :: Env -> Exp -> Err Type
inferNumeric env exp = do
      (typ, aexp) <- inferExp env exp
      if elem typ [Tint, Tdouble] then
          return typ
        else
          fail $ "type of expression " ++ printTree exp    

inferNumericBin :: Env -> Exp -> Exp -> [Type] -> String -> Err (Type, A.Exp, A.Exp)
inferNumericBin env exp0 exp1 okTypes op = do
                  (typ, aexp) <- inferExp env exp0
                  (typ1, aexp1) <- inferExp env exp1
                  if (elem typ okTypes && elem typ1 okTypes || elem typ [Tbool] && elem typ1 [Tbool] && elem op ["l"])
                    then 
                      if elem Tdouble [typ, typ1]  then return (Tdouble, aexp, aexp1)
                      else return (typ1, aexp, aexp1)
                    else
                      fail $ "Wrong type of expression " ++ printTree typ ++ printTree typ1
