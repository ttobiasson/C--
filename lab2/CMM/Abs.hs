

module CMM.Abs where

-- Haskell module generated by the BNF converter




newtype Id = Id ((Int,Int),String) deriving (Eq, Ord, Show, Read)
data Program = PDefs [Def]
  deriving (Eq, Ord, Show, Read)

data Def = DFun Type Id [Arg] [Stm]
  deriving (Eq, Ord, Show, Read)

data Type = Tbool | Tdouble | Tint | Tvoid
  deriving (Eq, Ord, Show, Read)

data Arg = ADecl Type Id
  deriving (Eq, Ord, Show, Read)

data Stm
    = SExp Exp
    | SDecl Type [Id]
    | SInit Type Id Exp
    | SReturn Exp
    | SWhile Exp Stm
    | SBlock [Stm]
    | SIfElse Exp Stm Stm
  deriving (Eq, Ord, Show, Read)

data Exp
    = EInt Integer
    | EDouble Double
    | ETrue
    | EFalse
    | EId Id
    | ECall Id [Exp]
    | EPIncr Id
    | EPDecr Id
    | EIncr Id
    | EDecr Id
    | EMul Exp Exp
    | EDiv Exp Exp
    | EAdd Exp Exp
    | ESub Exp Exp
    | ELt Exp Exp
    | EGt Exp Exp
    | ELEq Exp Exp
    | EGEq Exp Exp
    | EEq Exp Exp
    | ENEq Exp Exp
    | EAnd Exp Exp
    | EOr Exp Exp
    | EAss Id Exp
  deriving (Eq, Ord, Show, Read)
