{-# LANGUAGE LambdaCase #-}
module Interpreter (interpret, Strategy(..)) where
import Control.Monad.Reader
import Control.Monad.Except
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Maybe
import Fun.Abs
import Fun.Print

data Strategy = CallByName | CallByValue

data Val = VInt Integer | VClosure Ident Exp Env

type Err = Except String
type Sig = Map Ident Exp -- Function environment
type Env = Map Ident Val -- Variable environment
    
type Eval = ReaderT St Err

data St = St
      { stStrategy :: Strategy
      , stSig      :: Sig 
      , stEnv      :: Env }

errorMsg =  "INTERPRETATION ERROR: "

interpret :: Strategy -> Program -> Err Integer
interpret strategy (Prog defs (DMain mainExp)) =
  let sig = Map.fromList $ map (\ (DDef id args exp) -> (id, foldr EAbs exp args)) defs in
  let initSt = St strategy sig Map.empty in
   eval mainExp `runReaderT` initSt >>=
    \case 
    VInt i      -> return i
    _           -> fail $ errorMsg ++ "Badly written main"

eval :: Exp -> Eval Val
eval e =
  asks stStrategy >>= \strategy ->
  asks stSig      >>= \sig ->
  asks stEnv      >>= \env ->

  case e of  
    EInt i -> return $ VInt i
    EId id -> 
      case lookupid id env of
        Just val -> 
          case strategy of
            CallByValue -> return val
            _           -> case val of
                  VInt i               -> return val
                  VClosure id' exp env -> evalClosure env . eval $ exp 
        _ -> 
          case Map.lookup id sig of
            Just exp -> evalClosure Map.empty . eval $ exp
            _        -> fail errorMsg
            
    EAdd exp0 exp1 -> 
      eval exp0 >>= \val1 -> 
      eval exp1 >>= \val2 ->
      case (val1, val2) of
        (VInt e, VInt a) -> return $ VInt (e + a)
        _                -> fail $ errorMsg ++ "Expression not on correct form"

    ESub exp0 exp1 ->  
      eval exp0 >>= \val1 -> 
      eval exp1 >>= \val2 ->
      case (val1, val2) of
        (VInt a, VInt e) -> return $ VInt (a - e)
        _                -> fail $ errorMsg ++ "Expression not on correct form"
          
    ELt  exp0 exp1 -> 
      eval exp0 >>= \val1 -> 
      eval exp1 >>= \val2 ->
      case (val1, val2) of
        (VInt e, VInt a) -> return $ VInt (if e < a then 1 else 0)
        _                -> fail $ errorMsg ++ "Expression not on correct form"

    EAbs id exp ->  return $ VClosure id exp env

    ECall exp0 exp1 ->
      eval exp0 >>= \case 
        VClosure id' exp' env' -> 
          case strategy of
            CallByValue -> eval exp1 >>= \u -> evalClosure (update id' u env') . eval $ exp'
            _           -> eval (EAbs id' exp1) >>= \u -> evalClosure (update id' u env') . eval $ exp'
        _ -> fail $ errorMsg ++ "Not a function"      

    EIf bool true false -> 
      eval bool >>= \case
        VInt i -> if i == 1 then eval true else eval false
        _      -> fail $ errorMsg ++ "If-statement that does not eval to true or false: "
-- Auxillary functions
-- Looks up the id's value in the environment 
lookupid :: Ident -> Env -> Maybe Val
lookupid id env = 
   case Map.lookup id env of
    Nothing  -> fail $ errorMsg ++ "No variable with that id " ++ printTree id
    Just val -> return val
    
--updates the id with a new value in the current environment
update :: Ident -> Val -> Env -> Env
update = Map.insert
  
evalClosure :: Env -> Eval e -> Eval e
evalClosure env = local (\st -> st { stEnv = env }) 