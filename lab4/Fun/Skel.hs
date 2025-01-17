module Fun.Skel where

-- Haskell module generated by the BNF converter

import Fun.Abs
import Fun.ErrM
type Result = Err String

failure :: Show a => a -> Result
failure x = Bad $ "Undefined case: " ++ show x

transIdent :: Ident -> Result
transIdent x = case x of
  Ident string -> failure x
transProgram :: Program -> Result
transProgram x = case x of
  Prog defs main -> failure x
transMain :: Main -> Result
transMain x = case x of
  DMain exp -> failure x
transDef :: Def -> Result
transDef x = case x of
  DDef ident idents exp -> failure x
transExp :: Exp -> Result
transExp x = case x of
  EId ident -> failure x
  EInt integer -> failure x
  ECall exp1 exp2 -> failure x
  EAdd exp1 exp2 -> failure x
  ESub exp1 exp2 -> failure x
  ELt exp1 exp2 -> failure x
  EIf exp1 exp2 exp3 -> failure x
  EAbs ident exp -> failure x

