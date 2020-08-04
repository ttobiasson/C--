{-# LANGUAGE LambdaCase #-}

module Interpreter where

import Debug.Trace

import Control.Monad
import Control.Monad.State

import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map

import CMM.Abs
import CMM.Print
import CMM.ErrM

-- | Environment.
type Env   = [Block]
type Block = Map String Val

data Val
  = VInt Integer
  | VBool Bool
  | VDouble Double
  | VUndefined
  | VVoid
  deriving (Eq, Ord, Show)

type Sig = Map String Def


-- | Interpreter state.
data St = St
  { stSig :: Sig
  , stEnv :: Env
  }

-- | Interpreter monad.
type Eval = StateT St IO

stringId :: Id -> String
stringId (Id (_,s)) = s

stringIds :: [Id] -> [String]
stringIds [] = []
stringIds ((Id (_, s)):ids) = s:(stringIds ids)


interpret :: Program -> IO ()
interpret (PDefs ds) = do
  let sig    = Map.fromList $ map (\ d@(DFun _ f _ _) -> (stringId f,d)) ds
  let initSt = St { stSig = sig, stEnv = [] }

  case Map.lookup ("main") sig of
    Just (DFun _ _ _ ss) -> flip evalStateT initSt $ do
      newBlock Map.empty
      evalStms ss
      return ()

evalStms :: [Stm] -> Eval (Maybe Val)
evalStms [] = return Nothing
evalStms (stm:stms) = do 
  val <- (evalStm stm)
  case val of 
      (Just x) -> return $ Just x
      Nothing -> evalStms stms

evalStm :: Stm -> Eval (Maybe Val) 
evalStm = \case

<<<<<<< HEAD:lab2/Interpreter.hs
  SInit t x e -> do 
     val <- evalExp e 
     case val of 
        VUndefined -> fail $ " Declared to not instantiated varible "
        _          -> do
                    addBind x val
                    return Nothing
=======
  SInit t x e -> evalExp e >>= \v -> addBind x v >>= \() -> return Nothing
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/Interpreter.hs
    

  SDecl typ ids -> do
    mapM_ (\i -> newVar  i) (stringIds ids)
    return Nothing

  SExp e -> do
    evalExp e
    return Nothing

  SWhile exp stm -> whileHelp exp stm
 
  SIfElse exp stm stm0 -> do
    newBlock Map.empty
    v <- evalExp exp
    newBlock Map.empty;
    case v of
      (VBool True) -> do 
                    
                      v <- evalStm stm 
                      removeBlock
                      case v of 
                        (Just x) -> return $ Just x
                        Nothing  -> return Nothing 
      (VBool False) -> do 
                      
                      v <- evalStm stm0
                      removeBlock
                      case v of 
                        (Just x) -> return $ Just x
                        Nothing -> return Nothing

  SBlock stms -> do
    newBlock Map.empty 
    value <- evalStms stms

    case value of

      (Just x) -> removeBlock >>= \() -> return $ Just x

      Nothing -> removeBlock >>= \() -> return Nothing
        

<<<<<<< HEAD:lab2/Interpreter.hs
  SReturn exp -> evalExp exp >>= \val -> if val == VUndefined then fail $ " Variable not instantiated" 
                                         else return $ Just val
=======
  SReturn exp -> evalExp exp >>= \val -> return $ Just val
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/Interpreter.hs

evalExp :: Exp -> Eval Val
evalExp = \case
  ETrue  -> return $ VBool True
  EFalse -> return $ VBool False
  EDouble d -> return $ VDouble d
  EInt i -> return $ VInt i
  EId  x -> lookupVal x
<<<<<<< HEAD:lab2/Interpreter.hs
  EAss id exp -> do
                 val <- evalExp exp
                 case val of
                            VUndefined -> fail $ " Not initialized variable"
                            _         -> do 
                                            updateVar id val 
                                            return val
=======
  EAss id exp -> evalExp exp >>= \val -> updateVar id val >>= \() -> return val
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/Interpreter.hs
    
  EMul a b -> evalExp a >>= \q -> evalExp b >>= \e -> return $ mulVal q e
  EAdd a b  -> evalExp a >>= \q -> evalExp b >>= \e -> return $ addVal q e
  ESub a b  -> evalExp a >>= \q -> evalExp b >>= \e -> return $ subVal q e
  EDiv a b -> evalExp a >>= \q -> evalExp b >>= \e -> return $ divVal q e

<<<<<<< HEAD:lab2/Interpreter.hs
  ECall  (Id (_, "printInt")) [e] ->evalExp e >>= \(VInt i) -> liftIO $ print i >>= \() -> return $ VVoid
  
  ECall (Id (_, "printDouble")) [e] -> do 
    val <- evalExp e
    case val of 
      (VDouble i) -> liftIO $ print i >>= \() -> return $ VVoid
      (VInt i) -> liftIO $ print ((fromIntegral i)*1.0) >>= \() -> return $ VVoid

  ECall (Id (_, "readInt")) [] -> let line = getLine in liftIO line >>= \line1 -> 
                                  let x = (read line1 :: Integer) in return $ VInt x
   
=======
  ECall  (Id (_, "printInt")) [e] ->evalExp e >>= \(VInt i) -> liftIO $ print i >>= 
                                                  \() -> return $ VVoid

  ECall (Id (_, "printDouble")) [e] -> evalExp e >>= \val -> case val of 
               (VDouble i) -> liftIO $ print i >>= \() -> return $ VVoid
               (VInt i) -> liftIO $ print ((fromIntegral i)*1.0) >>= 
                \() -> return $ VVoid

  ECall (Id (_, "readInt")) [] -> let line = getLine in liftIO line >>= \line1 -> 
                                  let x = (read line1 :: Integer) in return $ VInt x
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/Interpreter.hs
  ECall (Id (_, "readDouble")) [] -> let line = getLine in liftIO line >>= \line1 -> 
                                     let x = (read line1 :: Double) in return $ VDouble x
   
  ECall id xs -> do
    sig <- gets stSig
    let q = Map.lookup (stringId id) sig 
    case q of
        Nothing -> fail $ "Wrong for function " ++ printTree id
        Just (DFun typ id args stms) -> do
            newBlock Map.empty
            helpFunc args xs
            res <- evalStms stms
            removeBlock         
            case res of
                (Just x) -> return x
                Nothing -> return VVoid

<<<<<<< HEAD:lab2/Interpreter.hs
  EPIncr id -> lookupVal id >>= \val -> let newVal = addVal val (VInt 1) in updateVar id newVal >>= \() -> return val
  EPDecr id -> lookupVal id >>= \val -> let newVal = subVal val (VInt 1) in updateVar id newVal >>= \() -> return val
  EIncr id -> lookupVal id >>= \val -> let newVal = addVal val (VInt 1) in updateVar id newVal >>= \() -> return newVal
  EDecr id -> lookupVal id >>= \val -> let newVal = subVal val (VInt 1) in updateVar id newVal >>= \() -> return newVal
    
  EAnd exp exp1 -> do
    res <- evalExp exp
    case res of
        (VBool False) -> return $ VBool False
        (VBool True)  -> evalExp exp1
        VUndefined -> fail $ "The variable " ++ printTree (show res) ++ " is not instanciated"

  EOr exp exp1 -> do
    val <- evalExp exp
    case val of
        (VBool False) -> evalExp exp1
        (VBool True) -> return (VBool True)
        VUndefined -> fail $ "The variable " ++ printTree (show val) ++ " is not instanciated"
        
  ELt exp exp1 -> do
    val <- evalExp exp
    val1 <- evalExp exp1
    return $ compareVal val val1 (<)

  EGt exp exp1 -> do
    val <- evalExp exp
    val1 <- evalExp exp1
    return $ compareVal val val1 (>)
  ELEq exp exp1 -> do
    val <- evalExp exp
    val1 <- evalExp exp1
    return $ compareVal val val1 (<=)
  EGEq exp exp1 -> do
    val <- evalExp exp
    val1 <- evalExp exp1
    return $ compareVal val val1 (>=)

  EEq exp exp1 -> do
    val <-  evalExp exp
    val1 <- evalExp exp1
    case elem val [VBool True, VBool False] of
      True -> return $ compareValBool val val1 (==)
      False -> return $ compareVal val val1 (==)
    
  ENEq exp exp1 -> do
    val <-  evalExp exp
    val1 <- evalExp exp1
    case elem val [VBool True, VBool False] of
      True -> return $ compareValBool val val1 (/=)
      False -> return $ compareVal val val1 (/=)
    
-- * Auxiliary functions


=======
  EPIncr id -> lookupVal id >>= \val -> let newVal = addVal val (VInt 1) in 
               updateVar id newVal >>= \() -> return val
  EPDecr id -> lookupVal id >>= \val -> let newVal = subVal val (VInt 1) in 
               updateVar id newVal >>= \() -> return val
  EIncr id -> lookupVal id >>= \val -> let newVal = addVal val (VInt 1) in 
              updateVar id newVal >>= \() -> return newVal
  EDecr id -> lookupVal id >>= \val -> let newVal = subVal val (VInt 1) in 
              updateVar id newVal >>= \() -> return newVal
    
  EAnd exp exp1 -> evalExp exp >>= \res -> case res of (VBool False) -> return (VBool False)
                                                       (VBool True)  -> evalExp exp1
 
  EOr exp exp1 -> evalExp exp >>= \val -> case val of (VBool False) -> evalExp exp1 
                                                      (VBool True) -> return (VBool True)

  ELt exp exp1 -> evalExp exp >>= \val -> evalExp exp1 >>= \val1 -> 
                  return $ compareVal val val1 (<)
  EGt exp exp1 -> evalExp exp >>= \val -> evalExp exp1 >>= \val1 -> 
                  return $ compareVal val val1 (>)
  ELEq exp exp1 -> evalExp exp >>= \val -> evalExp exp1 >>= \val1 ->           
                   return $ compareVal val val1 (<=)
  EGEq exp exp1 -> evalExp exp >>= \val -> evalExp exp1 >>= \val1 -> 
                   return $ compareVal val val1 (>=)
    
  EEq exp exp1 -> evalExp exp >>= \val -> evalExp exp1 >>= \val1 -> 
    case elem val [VBool True, VBool False] of 
      True -> return $ compareValBool val val1 (==)
      False -> return $ compareVal val val1 (==)
    
  ENEq exp exp1 -> evalExp exp >>= \val -> evalExp exp1 >>= \val1 -> 
    case elem val [VBool True, VBool False] of 
      True -> return $ compareValBool val val1 (/=)
      False -> return $ compareVal val val1 (/=)

-- * Auxiliary functions
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/Interpreter.hs
compareVal :: Val -> Val-> (Double -> Double -> Bool) -> Val
compareVal (VInt t1) (VInt t2) op = VBool(op (fromIntegral t1) (fromIntegral t2))
compareVal (VDouble t1) (VDouble t2) op = VBool(op t1 t2)
compareVal (VInt t1) (VDouble t2) op = VBool(op (fromIntegral t1) t2)
compareVal (VDouble t1) (VInt t2) op = VBool(op t1 (fromIntegral (t2)))

<<<<<<< HEAD:lab2/Interpreter.hs

=======
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/Interpreter.hs
compareValBool :: Val -> Val-> (Bool -> Bool -> Bool) -> Val
compareValBool (VBool t1) (VBool t2) op = VBool( op t1 t2)

newVar :: String -> Eval ()
<<<<<<< HEAD:lab2/Interpreter.hs
newVar id = do
  xs <- gets stEnv
  let block = head xs
  if Map.member id block then
    fail $ "Binding already exists " ++ printTree id
  else do
    let block1 = Map.insert id VUndefined block
    modify $ \ st -> st { stEnv = block1 : tail xs}
=======
newVar id = gets stEnv >>= \env -> let block = head env in 
  if Map.member id block then 
      fail $ "Binding already exists " ++ printTree id
  else let block1 = Map.insert id VUndefined block in
           modify $ \ st -> st { stEnv = block1 : tail env}
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/Interpreter.hs

updateVar :: Id -> Val -> Eval ()
updateVar id val = gets stEnv >>= \env -> if (Map.notMember (stringId id) (Map.unions env)) then return ()
                                          else updateVar' env id val [] >>= \() -> return ()

updateVar' :: Env -> Id -> Val -> [Block] -> Eval ()
updateVar' [] id val st1 = return ()
<<<<<<< HEAD:lab2/Interpreter.hs
updateVar' (c:cs) id val st1 = 
  case Map.lookup (stringId id) c of

    Just k -> modify $ \ st -> st { stEnv = (reverse st1) ++ ((Map.insert (stringId id) val c) : cs) }
      
    Nothing -> updateVar' cs id val (c:st1)

whileHelp :: Exp -> Stm -> Eval (Maybe Val)
whileHelp exp stm = do
    val <- evalExp exp
    newBlock Map.empty
    case val of

      (VBool True) -> do 
                
        val <- evalStm stm
        
        case val of 
            (Just x) -> do
                         removeBlock
                         return $ Just x
            Nothing -> do
                          removeBlock
                          whileHelp exp stm
        
      (VBool False) -> do
        removeBlock
        return Nothing


helpFunc :: [Arg] -> [Exp] -> Eval ()
helpFunc [] _ = return ()
helpFunc ((ADecl typ id ) : adecls ) ( x : xs ) = do
  (block:env) <- gets stEnv
  removeBlock
  ev <- evalExp x
  newBlock block
  newVar (stringId id)
  updateVar id ev
  helpFunc adecls xs

=======
updateVar' (c:cs) id val st1 = case Map.lookup (stringId id) c of
    
  Just k -> modify $ \ st -> st { stEnv = (reverse st1) ++ ((Map.insert (stringId id) val c) : cs) }  
  Nothing -> updateVar' cs id val (c:st1)

whileHelp :: Exp -> Stm -> Eval (Maybe Val)
whileHelp exp stm = evalExp exp >>= \val -> newBlock Map.empty >>= \() ->
    case val of

      (VBool True) -> evalStm stm >>= \val -> case val of 

            (Just x) -> removeBlock >>= \() -> return $ Just x
            Nothing -> removeBlock >>= \() -> whileHelp exp stm

      (VBool False) -> removeBlock >>= \()-> return Nothing
        
helpFunc :: [Arg] -> [Exp] -> Eval ()
helpFunc [] _ = return ()
helpFunc ((ADecl typ id ) : adecls ) ( x : xs ) = evalExp x >>= 
                                     \ev -> updateVar id ev >>= 
                                     \() -> helpFunc adecls xs
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/Interpreter.hs
newBlock :: Block -> Eval ()
newBlock block = modify $ \ st -> st { stEnv = block : stEnv st }

removeBlock :: Eval ()
removeBlock = modify $ \ st -> st { stEnv = tail $ stEnv st }

addBind :: Id -> Val -> Eval ()
addBind x v = do
  (block:env) <- gets stEnv
  modify $ \ st -> st { stEnv = Map.insert (stringId x) v block : env }

<<<<<<< HEAD:lab2/Interpreter.hs

=======
addArgs :: [(String, Type)] -> Block -> Block
addArgs [] block = block
addArgs ( (s, t) : xs ) block = let newBlock = Map.insert s VUndefined block in 
                                    addArgs xs newBlock 
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/Interpreter.hs
mulVal :: Val -> Val -> Val
mulVal (VInt t1) (VInt t2)          = VInt ( t1 * t2 )
mulVal (VDouble t1) (VDouble t2)    = VDouble ( t1 * t2 )
mulVal (VDouble t1) (VInt t2)       = VDouble (t1 * (fromIntegral t2))
mulVal (VInt t1) (VDouble t2)       = VDouble ((fromIntegral t1) * (t2))
<<<<<<< HEAD:lab2/Interpreter.hs

=======
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/Interpreter.hs

addVal :: Val -> Val -> Val
addVal (VInt val1) (VInt val2) = VInt ( val1 + val2 )
addVal (VDouble val1) (VDouble val2) = VDouble ( val1 + val2 )
addVal (VDouble val1) (VInt val2) = VDouble ( val1 + (fromIntegral val2) )

subVal :: Val -> Val -> Val
subVal (VInt tal1) (VInt tal2) = VInt ( tal1 - tal2 )
subVal (VDouble tal1) (VDouble tal2) =  VDouble ( tal1 - tal2 )
subVal (VDouble val1) (VInt val2) = VDouble ( val1 - (fromIntegral val2) )
<<<<<<< HEAD:lab2/Interpreter.hs
subVal (VInt val1) (VDouble val2) = VDouble ( (fromIntegral val1) - val2 )
=======
subVal (VInt val1) (VDouble val2) = VDouble ((fromIntegral val1) - val2 )
>>>>>>> 1fd517b3dcc8610c07ed41a448bc49184f1493ee:plt-master/lab2/Interpreter.hs

divVal :: Val -> Val -> Val
divVal (VInt tal1) (VInt tal2) = VInt $ floor ( fromIntegral tal1 / fromIntegral tal2 )
divVal (VDouble tal1) (VDouble tal2) =  VDouble ( tal1 / tal2 )

fromArgs :: [Arg] -> [Type]
fromArgs [] = []
fromArgs ((ADecl typ id):args) = typ : fromArgs args

fromArgsId :: [Arg] -> [(String, Type)]
fromArgsId [] = []
fromArgsId ((ADecl typ id):args) = (stringId id, typ):fromArgsId args

lookupVal :: Id -> Eval Val
lookupVal x = do
  env <- gets stEnv
  case mapMaybe (Map.lookup (stringId x)) env of
    (v:_) ->  return v
    _ -> fail "couldn't lookupVal"
