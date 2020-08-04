{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE LambdaCase #-}

module Compiler where

import Control.Monad
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.RWS
import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map
import qualified TypeChecker as T
import Annotated
import CMM.Abs (Type(..), Id(..), Arg(..))

data St = St
  { cxt           :: Cxt   -- ^ Context.
  , limitLocals   :: Int   -- ^ Maximal size for locals encountered.
  , currentStack  :: Int   -- ^ Current stack size.
  , limitStack    :: Int   -- ^ Maximal stack size encountered.
  , nextLabel     :: Label -- ^ Next jump label (persistent part of state).
  }

type Sig = Map Id Fun

-- | Function names bundled with their type.
data Fun = Fun { funId :: Id, funFunType :: FunType }

data FunType = FunType Type [Type]

type Cxt = [Block]
type Block = Map Id (Addr, Type)

newtype Label = L { theLabel :: Int }
  deriving (Eq, Enum, Show)

initSt :: St
initSt = St
  { cxt = [Map.empty]
  , limitLocals   = 0
  , currentStack  = 0
  , limitStack    = 100
  , nextLabel     = L 0
  }
type Output = [String]

type Compile = RWS Sig Output St

-- | Builtin-functions
builtin :: [(Id, Fun)]
builtin =
  [ (Id "printInt"   , Fun (Id "Runtime/printInt"   ) $ FunType Tvoid [Tint]),
    (Id "printDouble"  , Fun (Id "Runtime/printDouble"  ) $ FunType Tvoid [Tdouble]),
    (Id "readInt"   , Fun (Id "Runtime/readInt"   ) $ FunType Tint []),
    (Id "readDouble"   , Fun (Id "Runtime/readDouble"   ) $ FunType Tdouble [])
  ]
-- | Entry point.
compile :: String  -- ^ Class name.
  -> Program -- ^ Type-annotated program.
  -> String  -- ^ Generated jasmin source file content.
compile name prg@(PDefs defs) = unlines w
  where
  sigEntry def@(DFun _ f@(Id x) _ _ ) = (f, Fun (Id $ name ++ "/" ++ x) $ funType def)
  sig = Map.fromList $ builtin ++ map sigEntry defs
  w   = snd $ evalRWS (compileProgram name prg) sig initSt

compileProgram :: String -> Program -> Compile ()
compileProgram name (PDefs defs) = do
  tell header
  mapM_ compileFun defs
  where
  header =
    [ ";; BEGIN HEADER"
    , ""
    , ".class public " ++ name
    , ".super java/lang/Object"
    , ""
    , ".method public <init>()V"
    , "  .limit locals 1"
    , ""
    , "  aload_0"
    , "  invokespecial java/lang/Object/<init>()V"
    , "  return"
    , ""
    , ".end method"
    , ""
    , ".method public static main([Ljava/lang/String;)V"
    , "  .limit locals 1"
    , "  .limit stack  1"
    , ""
    , "  invokestatic " ++ name ++ "/main()I"
    , "  pop"
    , "  return"
    , ""
    , ".end method"
    , ""
    , ";; END HEADER"
    ]

compileFun :: Def -> Compile ()
compileFun def@(DFun t f args ss) = do
  -- function header
  tell [ "", ".method public static " ++ toJVM (Fun f $ funType def) ]
  -- prepare environment
  lab <- gets nextLabel
  put initSt{ nextLabel = lab }
  mapM_ (\ (ADecl t' x) -> newVar t' x) args
  -- compile statements
  w <- grabOutput $
    mapM_ compileStm ss
  -- output limits
  ll <- gets limitLocals
  ls <- gets limitStack
  tell [ "  .limit locals " ++ show ll
       , "  .limit stack  " ++ show ls
       ]
  -- output code, indented by 2
  tell $ map (\ s -> if null s then s else "  " ++ s) w
  case t of 
      Tvoid   -> tell ["return"]
      Tint    -> tell ["ireturn"]
      Tdouble -> tell ["dreturn"]
      Tbool   -> tell ["ireturn"]
  -- function footer
  tell [ "", ".end method"]

compileStm :: Stm -> Compile ()
compileStm s = do
  -- Printing a comment
  let top = stmTop s
  unless (null top) $
    tell $ map (";; " ++) $ lines top

  case s of
    SExp typ exp -> do
      compileExp exp
      emit $ Pop typ
      
    SDecl typ ids -> mapM_ (newVar typ) ids
    
    SInit typ id exp -> do
      case inferExp exp of 
        Tint | typ == Tdouble -> compileExp exp >> tell ["i2d"]
             | otherwise      -> compileExp exp
        _   -> compileExp exp
      newVar typ id
      (addr, _) <- lookupVar id
      emit $ Store typ addr

    SWhile exp stm -> do
      test <- newLabel
      end  <- newLabel
      emit $ Label test
      compileExp exp
      emit $ IfZero end
      newBlock
      compileStm stm
      removeBlock
      emit $ Goto test
      emit $ Label end
      
    SReturn typ exp -> do
      compileExp exp
      emit $ Return typ
    
    SBlock exp -> do
      newBlock
      mapM_ compileStm exp
      removeBlock

    SIfElse exp stm0 stm1 -> do
      true <- newLabel
      false <- newLabel
      compileExp exp
      emit $ IfZero false 
      newBlock
      compileStm stm0
      removeBlock
      emit $ Goto true
      emit $ Label false
      newBlock
      compileStm stm1
      removeBlock
      emit $ Label true
      
compileExp :: Exp -> Compile ()
compileExp e =
  case e of
    ETrue -> emit $ Push 1
    EFalse -> emit $ Push 0
    EInt i -> emit $ Push i
    EDouble i -> emit $ DPush i

    EId x -> do
      (addr, typ) <- lookupVar x
      emit $ Load typ addr
      
    EPIncr id -> do
      (addr, typ) <- lookupVar id 
      emit $ Load typ addr
      emit $ Dup typ
      checkDouble typ
      emit $ Add typ
      emit $ Store typ addr

    EPDecr id -> do
      (addr, typ) <- lookupVar id
      emit $ Load typ addr
      emit $ Dup typ
      checkDouble typ
      emit $ Sub typ
      emit $ Store typ addr
    
    EIncr id -> do
      (addr, typ) <- lookupVar id
      emit $ Load typ addr
      checkDouble typ
      emit $ Add typ
      emit $ Dup typ
      emit $ Store typ addr

    EDecr id -> do 
      (addr, typ) <-lookupVar id
      emit $ Load typ addr
      checkDouble typ
      emit $ Sub typ
      emit $ Dup typ
      emit $ Store typ addr

    EAnd exp0 exp1 -> do
      compileExp exp0
      first <- newLabel
      end <- newLabel
      emit $ IfZero first
      compileExp exp1
      emit $ IfZero first
      emit $ Push 1
      emit $ Goto end
      emit $ Label first
      emit $ Push 0
      emit $ Label end 

    EOr exp0 exp1 -> do
      compileExp exp0
      first <- newLabel
      end <- newLabel
      second <- newLabel
      emit $ IfZero first
      emit $ Push 1
      emit $ Goto end
      emit $ Label first
      compileExp exp1
      emit $ IfZero second
      emit $ Push 1
      emit $ Goto end
      emit $ Label second
      emit $ Push 0
      emit $ Label end
      
    ECall f x -> do
      mapM_ compileExp x
      sig <- ask
      let fun = fromMaybe (error "No function ") $ Map.lookup f sig
      if function fun  == "Tdouble"  && (elem Tint (map inferExp x)) then do
        tell ["i2d"]
        emit $ Call fun
      else
        emit $ Call fun

    EMul typ exp0 exp1 -> inferExps exp0 exp1 >> (emit $ Mul typ)
    EDiv typ exp0 exp1 -> inferExps exp0 exp1 >> (emit $ Div typ)
    EAdd typ exp0 exp1 -> inferExps exp0 exp1 >> (emit $ Add typ)
    ESub typ exp0 exp1 -> inferExps exp0 exp1 >> (emit $ Sub typ)
    
    ELt typ exp0 exp1 -> 
      case typ of
        Tdouble -> do
           true <- newLabel
           end <- newLabel
           inferExps exp0 exp1
           tell ["dcmpl"]
           tell ["iflt " ++ getTheLabel true]
           emit $ Push 0
           emit $ Goto end
           emit $ Label true
           emit $ Push 1
           emit $ Label end
        _ ->  do
           true <- newLabel
           emit $ Push 1
           inferExps exp0 exp1
           emit $ IfLt typ true
           emit $ Pop typ
           emit $ Push 0
           emit $ Label true
      
    EGt typ exp0 exp1 -> 
      case typ of
        Tdouble -> do
           true <- newLabel
           end <- newLabel
           inferExps exp0 exp1
           tell ["dcmpg"]
           tell ["ifgt " ++ getTheLabel true]
           emit $ Push 0
           emit $ Goto end
           emit $ Label true
           emit $ Push 1
           emit $ Label end
        _ ->  do
           true <- newLabel
           emit $ Push 1
           inferExps exp0 exp1
           emit $ IfGt typ true
           emit $ Pop typ
           emit $ Push 0
           emit $ Label true
      
    ELEq typ exp0 exp1 -> 
     case typ of
     Tdouble -> do
        true <- newLabel
        end <- newLabel
        inferExps exp0 exp1
        tell ["dcmpl"]
        tell ["ifle " ++ getTheLabel true]
        emit $ Push 0
        emit $ Goto end
        emit $ Label true
        emit $ Push 1
        emit $ Label end
     _ ->  do
        true <- newLabel
        emit $ Push 1
        inferExps exp0 exp1
        emit $ IfLEq typ true
        emit $ Pop typ
        emit $ Push 0
        emit $ Label true
      
    EGEq typ exp0 exp1 -> 
     case typ of
      Tdouble -> do
        true <- newLabel
        end <- newLabel
        inferExps exp0 exp1
        tell ["dcmpg"]
        tell ["ifge " ++ getTheLabel true]
        emit $ Push 0
        emit $ Goto end
        emit $ Label true
        emit $ Push 1
        emit $ Label end
      _ ->  do
        true <- newLabel
        emit $ Push 1
        inferExps exp0 exp1
        emit $ IfGEq typ true
        emit $ Pop typ
        emit $ Push 0
        emit $ Label true
      
    EEq typ exp0 exp1 -> 
      case typ of
        Tdouble -> do
          true <- newLabel
          end <- newLabel
          inferExps exp0 exp1
          tell ["dcmpg"]
          tell ["ifeq " ++ getTheLabel true]
          emit $ Push 0
          emit $ Goto end
          emit $ Label true
          emit $ Push 1
          emit $ Label end
        _ ->  do
          true <- newLabel
          emit $ Push 1
          inferExps exp0 exp1
          emit $ IfEq typ true
          emit $ Pop typ
          emit $ Push 0
          emit $ Label true
      
    ENEq typ exp0 exp1 -> 
      case typ of
        Tdouble -> do
          true <- newLabel
          end <- newLabel
          inferExps exp0 exp1
          tell ["dcmpg"]
          tell ["ifne " ++ getTheLabel true]
          emit $ Push 0
          emit $ Goto end
          emit $ Label true
          emit $ Push 1
          emit $ Label end
        _ ->  do
          true1 <- newLabel
          emit $ Push 1
          inferExps exp0 exp1
          emit $ IfNEq typ true1
          emit $ Pop Tbool
          emit $ Push 0
          emit $ Label true1

    EAss id exp -> do
      let typ1 = inferExp exp
      (a,t) <- lookupVar id
      case t of
        Tdouble | typ1 == Tint -> compileExp exp >> tell ["i2d"]
                | otherwise    -> compileExp exp >> tell ["nop"]
        Tint    | typ1 == Tdouble -> compileExp exp >> tell ["d2i"]
                | otherwise       -> compileExp exp >> tell ["nop"]
        _       -> compileExp exp
      emit $ Dup t
      emit $ Store t a
-- * Instructions and emitting
type Addr = Int

data Code
  = Store Type Addr  -- ^ Store stack content of type @Type@ in local variable @Addr@.
  | Load  Type Addr  -- ^ Push stack content of type @Type@ from local variable @Addr@.
  
  | Dup Type
  | Push Integer     -- ^ Put integer constant on the stack.
  | DPush Double     -- ^ Put double constant on the stack.
  | Pop Type         -- ^ Pop something of type @Type@ from the stack.
  | Return Type      -- ^ Return from method of type @Type@.
  | Add Type         -- ^ Add 2 top values of stack.
  | Sub Type         -- ^ Sub 2 top values of stack.
  | Div Type         -- ^ Divide 2 top values of stack.
  | Mul Type         -- ^ Multiply 2 top values of stack.
  | Call Fun         -- ^ Call function.

  | Label Label      -- ^ Define label.
  | Goto Label       -- ^ Jump to label. 
  
  | IfZero Label     -- ^ If top of stack is 0, jump to label.
  | IfLt Type Label       -- ^ If prev <  top, jump.
  | IfLEq Type Label      -- ^ If prev <=  top, jump.
  | IfGt Type Label       -- ^ If prev >  top, jump.
  | IfGEq Type Label      -- ^ If prev >=  top, jump.
  | IfEq Type Label       -- ^ If prev ==  top, jump.
  | IfNEq Type Label      -- ^ If prev !=  top, jump.
  | IfEqS Label

-- | Print a single instruction.  Also update stack limits
emit :: Code -> Compile ()
emit code =
  case code of 
    Store typ addr -> case typ of 
                    Tint    -> tell ["istore " ++ show addr]
                    Tdouble -> tell ["dstore " ++ show addr]
                    Tbool   -> tell ["istore " ++ show addr]

    Load typ addr  -> case typ of 
                    Tint    -> tell ["iload " ++ show addr]
                    Tdouble -> tell ["dload " ++ show addr]
                    Tbool   -> tell ["iload " ++ show addr]
    Return typ     -> case typ of
                    Tint    -> tell ["ireturn "]
                    Tdouble -> tell ["dreturn "]
                    Tbool   -> tell ["ireturn "]
                    Tvoid   -> tell ["return"]
                
    Call f 		     -> tell ["invokestatic " ++ toJVM f] 

    Pop typ        -> case typ of
                    Tint    -> tell ["pop "]
                    Tdouble -> tell ["pop2 "]
                    Tbool   -> tell ["pop "]
                    Tvoid   -> tell [""]

    Push i         -> tell["ldc " ++ show i]

    DPush d         -> tell["ldc2_w " ++ show d]

    Label i        -> tell[ "L" ++ show(theLabel i) ++ ":"]

    Goto l         -> tell["goto " ++ getTheLabel l]

    Add typ        -> case (trace (show typ) typ) of
                    Tint    -> tell["iadd"]
                    Tdouble -> tell["dadd"]
    
    Sub typ        -> case typ of 
                    Tint    -> tell["isub"]
                    Tdouble -> tell["dsub"]

    Div typ        -> case typ of 
                    Tint    -> tell["idiv"]
                    Tdouble -> tell["ddiv"]

    Mul typ        -> case typ of 
                    Tint    -> tell["imul"]
                    Tdouble -> tell["dmul"]

    Dup typ         | typ == Tdouble -> tell ["dup2"]
                    | otherwise -> tell ["dup"]
    
    IfZero label   -> tell ["ifeq "  ++ getTheLabel label ]

    IfLt typ label  | typ == Tint ->  tell ["if_icmplt " ++ getTheLabel label ]
                    | otherwise   -> do 
                      tell  ["dcmpg"] 
                      tell ["ifgt " ++ getTheLabel label]
                      tell ["goto " ++ getTheLabel label]

    IfLEq typ label | typ == Tint ->  tell ["if_icmple " ++ getTheLabel label ]
                    | otherwise   -> do 
                      tell  ["dcmpl"] 
                      tell ["ifge " ++ getTheLabel label]
                      tell ["goto " ++ getTheLabel label]

    IfGt typ label  | typ == Tint ->  tell ["if_icmpgt " ++ getTheLabel label ]
                    | otherwise   -> do 
                        tell  ["dcmpg"] 
                        tell ["ifgt " ++ getTheLabel label]
                        tell ["goto " ++ getTheLabel label]

    IfGEq typ label | typ == Tint ->  tell ["if_icmpge " ++ getTheLabel label ]
                    | otherwise   -> tell  ["dcmpg"] 

    IfNEq typ label | elem typ [Tint, Tbool] ->  tell ["if_icmpne " ++ getTheLabel label ]
                    | otherwise              -> tell  ["dcmpl"]
                    
    IfEq typ label  | elem typ [Tint, Tbool] ->  tell ["if_icmpeq " ++ getTheLabel label ]
                    | otherwise              -> tell  ["dcmpg"]
    IfEqS label     -> tell ["if_icmpeq " ++ getTheLabel label]
    
-- * Labels
getTheLabel :: Label -> String
getTheLabel i = "L" ++ show(theLabel i)

newLabel :: Compile Label
newLabel = do
  l <- gets nextLabel
  modify $ \ st -> st { nextLabel = succ l }
  return $ l
-- | Print top part of statement (for comments)
stmTop :: Stm -> String
stmTop s =
  case s of
    SWhile e _ -> "while (" ++ printTree e ++ ")"
    _ -> printTree s
-- * Auxiliary functions

checkDouble :: Type -> Compile ()
checkDouble t = 
  case t of
    Tdouble -> emit $ DPush 1.0
    Tint    -> emit $ Push 1

function :: Fun -> String
function (Fun id funtyp@(FunType retTyp (arg:argTypes))) = show arg
function (Fun id _) = ""

grabOutput :: Compile () -> Compile Output
grabOutput m = do
  r <- ask
  s  <- get
  let ((), s', w) = runRWS m r s
  put s'
  return w
-- * Auxiliary functions

funType :: Def -> FunType
funType (DFun t _ args _) = FunType t $ map (\ (ADecl t' _) -> t') args

stringId :: Id -> String
stringId (Id s) = s

toJVM :: Fun -> String
toJVM (Fun id funtyp@(FunType retTyp argTypes)) = stringId id ++ "(" ++ getArgTypes argTypes ++ ")" ++ getRetType retTyp

getRetType :: Type -> String
getRetType t = case t of 
              Tbool -> "Z"
              Tvoid -> "V"
              Tint  -> "I"
              Tdouble -> "D"

getArgTypes :: [Type] -> String
getArgTypes []    = ""
getArgTypes (t:ts)  = case t of 
                Tint    -> "I" ++ getArgTypes ts
                Tdouble -> "D" ++ getArgTypes ts
                Tbool   -> "Z" ++ getArgTypes ts
                Tvoid   -> "V" ++ getArgTypes ts

newVar :: Type -> Id -> Compile ()
newVar typ id = do
    c:cs <- gets cxt
    limloc <- gets limitLocals
    modify $ \ st -> st {cxt = ((Map.insert id (limloc, typ) c ):cs), limitLocals = if typ == Tdouble then limloc+2 else limloc +1}

lookupVar :: Id -> Compile (Addr, Type)
lookupVar id = do
  s <- gets cxt
  case filter (/=Nothing) . map (Map.lookup id) $ s of
    [] -> fail $ "Variable doesn't exist"
    (x:xs) -> return $ fromJust x
   
newBlock :: Compile ()
newBlock =  do
  cs <- gets cxt
  modify $ \ stack -> stack { cxt = Map.empty:cs}

removeBlock :: Compile ()
removeBlock =  do
  (c:cs) <- gets cxt
  modify $ \ stack -> stack { cxt = cs}

inferExps :: Exp -> Exp -> Compile ()
inferExps exp0 exp1 = 
  case inferExp exp0 of
    Tdouble | inferExp exp1 == Tint -> do compileExp exp0
                                          compileExp exp1
                                          tell ["i2d"]
            | otherwise   -> compileExp exp0  >> compileExp exp1

    Tint    | inferExp exp1 == Tdouble -> do compileExp exp1 
                                             compileExp exp0
                                             tell ["i2d"]
            | otherwise    -> compileExp exp0  >> compileExp exp1
    _ -> compileExp exp0 >> compileExp exp1

inferExp :: Exp -> Type
inferExp exp =  
  case exp of
    ETrue      -> Tbool
    EFalse     -> Tbool
    EInt n     -> Tint
    EDouble n  -> Tdouble
    EAdd t a b   -> trace (show t) t
    EMul t a b   -> t
    EDiv t a b   -> t
    ESub t a b   -> t
    _          -> Tvoid

inNewBlock :: Compile () -> Compile ()
inNewBlock f = do
  cs <- gets cxt
  modify $ \ stack -> stack { cxt = Map.empty:cs}
  f
  modify $ \ stack -> stack { cxt = cs}