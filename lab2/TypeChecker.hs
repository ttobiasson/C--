module TypeChecker where

import Control.Monad
import Data.Map (Map)
import qualified Data.Map as Map

import CMM.Abs
import CMM.Print
import CMM.ErrM
    
-- Different types --
type Env = (Sig, [Context])
type Sig = Map String ([Type], Type)
type Context = Map String Type

predefFunc = [("readInt",([], Tint)),
              ("readDouble",([], Tdouble)), 
              ("printDouble", ([Tdouble], Tvoid)),
              ("printInt", ([Tint], Tvoid))]

stringId :: Id -> String
stringId (Id (_,s)) = s

stringIds :: [Id] -> [String]
stringIds [] = []
stringIds ((Id (_, s)):ids) = s:(stringIds ids)

typecheck :: Program -> Err ()
typecheck (PDefs []) = return ()
typecheck (PDefs defs) = checkDefs (Map.fromList predefFunc, []) defs

checkDefs :: Env -> [Def] -> Err ()
checkDefs env []                                   = checkMain env
checkDefs env deffar@((def@(DFun typ id args stms)):defs) = do

  if elem (stringId id) (fromDefs defs) || (elem (stringId id ) ["readInt", "readDouble", "printDouble","printInt"]) then
    fail $ "Overloading is not permitted " 
  else do
    env1 <- buildSig env deffar
    env' <- checkDef env1 def
    checkDefs env' defs

checkDef :: Env -> Def -> Err Env
checkDef (sig, xs) (DFun typ id args stms) = do
  checkArgs args
  let theArgs = fromArgs args
  let env' = (sig, f (fromArgsId args) Map.empty : xs)
  (s, c:cs) <- checkStms env' id stms
  return (s, cs)

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

checkMain :: Env -> Err ()
checkMain env = do 
  saker <- lookupFunc env "main"
  case saker of
    ([], Tint) -> return ()
    _          -> fail $ "Main is not present or is ill-typed" 

fromDefs :: [Def] -> [String]
fromDefs [] = []
fromDefs ((DFun typ id args stms):defs) = (stringId id):(fromDefs defs)

checkArgs :: [Arg] -> Err ()
checkArgs []         = return ()
checkArgs ((ADecl typ id):args) = do
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
declVar env@(sig,c:context) ids typ = do
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

checkStm :: Env -> Id -> Stm -> Err Env
checkStm env@(sig,cs) id stm = case stm of
  SExp exp  -> do
    inferExp env exp
    return env
  SDecl typ ids  -> declVars env (stringIds ids) typ
  SInit typ id exp -> do
    env' <- declVar env [stringId id] typ
    checkExp env' typ exp
    return env'           
  SWhile exp stm  -> do
    checkExp env Tbool exp
    checkStm (sig, Map.empty:cs) id stm
    return env
  SReturn exp -> do 
    typ <- inferExp env exp
    (_, typ1) <- lookupFunc env $ stringId id 
    if (typ == typ1)
       then 
        return env
    else 
        fail $ "The function type " ++ printTree typ1 ++ " does not match " ++ printTree typ
  SBlock stm -> do
    (sig,c:cs) <- checkStms (sig,Map.empty:cs) id stm
    return (sig,cs)
  SIfElse exp stm0 stm1 -> do
    checkExp env Tbool exp
    checkStm (sig, Map.empty:cs) id stm0
    checkStm (sig, Map.empty:cs) id stm1
    return env

checkStms :: Env -> Id -> [Stm] -> Err Env
checkStms env id stms = case stms of 
                [] -> return env
                x:xs -> do 
                          envs <- checkStm env id x
                          checkStms envs id xs

checkExp :: Env -> Type -> Exp -> Err ()
checkExp env typ exp = do 
    typ2 <- inferExp env exp
    if(typ2 == typ || elem typ [Tdouble] && (elem typ2 [Tint] || elem typ2 [Tdouble])) then 
      return ()
    else 
        fail $ "type of " ++ printTree exp ++
               " expected " ++ printTree typ ++
               " but found" ++ printTree typ2

inferExp :: Env -> Exp -> Err Type
inferExp env x = case x of
  ETrue      -> return Tbool
  EFalse     -> return Tbool
  EInt n     -> return Tint
  EDouble n  -> return Tdouble
      
  EId id     -> lookupVar env $ stringId id
  EPIncr id  -> inferNumeric env (EId id)
  EPDecr id  -> inferNumeric env (EId id)
  EIncr id   -> inferNumeric env (EId id)
  EDecr id   -> inferNumeric env (EId id)

  EAnd exp0 exp1 ->
    inferNumericBin env exp0 exp1 [Tbool] "l"
  EOr exp0 exp1 -> 
    inferNumericBin env exp0 exp1 [Tbool] "l"
  EAss id exp -> do
    expType <- inferExp env exp
    idType <- inferExp env (EId id)
    if (elem expType [Tint, Tdouble] && elem idType [Tdouble]) || (elem expType [Tint] && elem idType [Tint, Tdouble] || elem idType [Tbool] && elem expType [Tbool]) then
      return expType
    else
      fail $ "Wrong type of variable and assigned value " ++ printTree expType ++ " id of type " ++ printTree idType
  ECall id exps -> do
    argtypes <- mapM (inferExp env) exps
    (args,rtype) <- lookupFunc env $ stringId id 
    if (args == argtypes || (elem Tdouble args && (elem Tdouble argtypes || elem Tint argtypes)) && (length args) == (length argtypes)) then
      return rtype
    else
      fail $ "Fail, wrong variable type for function arguments: " ++ printTree args ++ "    args: " ++ printTree argtypes
  EMul exp0 exp1 -> 
    inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
  EDiv exp0 exp1 -> 
    inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
  EAdd exp0 exp1 ->
    inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
  ESub exp0 exp1 -> 
    inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
  ELt exp0 exp1 -> do
    inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
    return Tbool
  EGt exp0 exp1 -> do
    inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
    return Tbool
  ELEq exp0 exp1 -> do
    inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
    return Tbool
  EGEq exp0 exp1 -> do 
    inferNumericBin env exp0 exp1 [Tint, Tdouble] "k"
    return Tbool
  EEq exp0 exp1 -> do
    inferNumericBin env exp0 exp1 [Tint, Tdouble] "l"
    return Tbool
  ENEq exp0 exp1 -> do
    inferNumericBin env exp0 exp1 [Tint, Tdouble] "l"
    return Tbool

inferNumeric :: Env -> Exp -> Err Type
inferNumeric env exp = do
      typ <- inferExp env exp
      if elem typ [Tint, Tdouble] then
          return typ
        else
          fail $ "type of expression " ++ printTree exp    
inferNumericBin :: Env -> Exp -> Exp -> [Type] -> String -> Err Type
inferNumericBin env exp0 exp1 okTypes op = do
                  typ <- inferExp env exp0
                  typ1 <- inferExp env exp1
                  if (elem typ okTypes && elem typ1 okTypes || elem typ [Tbool] && elem typ1 [Tbool] && elem op ["l"])
                    then 
                      return typ
                    else
                      fail $ "Wrong type of expression " ++ printTree exp1
