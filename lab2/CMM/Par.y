-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module CMM.Par where
import CMM.Abs
import CMM.Lex
import CMM.ErrM

}

%name pProgram Program
%name pDef Def
%name pListStm ListStm
%name pListDef ListDef
%name pListArg ListArg
%name pListId ListId
%name pListExp ListExp
%name pType Type
%name pArg Arg
%name pStm Stm
%name pExp6 Exp6
%name pExp5 Exp5
%name pExp4 Exp4
%name pExp3 Exp3
%name pExp2 Exp2
%name pExp1 Exp1
%name pExp Exp
-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%token
  '!=' { PT _ (TS _ 1) }
  '&&' { PT _ (TS _ 2) }
  '(' { PT _ (TS _ 3) }
  ')' { PT _ (TS _ 4) }
  '*' { PT _ (TS _ 5) }
  '+' { PT _ (TS _ 6) }
  '++' { PT _ (TS _ 7) }
  ',' { PT _ (TS _ 8) }
  '-' { PT _ (TS _ 9) }
  '--' { PT _ (TS _ 10) }
  '/' { PT _ (TS _ 11) }
  ';' { PT _ (TS _ 12) }
  '<' { PT _ (TS _ 13) }
  '<=' { PT _ (TS _ 14) }
  '=' { PT _ (TS _ 15) }
  '==' { PT _ (TS _ 16) }
  '>' { PT _ (TS _ 17) }
  '>=' { PT _ (TS _ 18) }
  'bool' { PT _ (TS _ 19) }
  'double' { PT _ (TS _ 20) }
  'else' { PT _ (TS _ 21) }
  'false' { PT _ (TS _ 22) }
  'if' { PT _ (TS _ 23) }
  'int' { PT _ (TS _ 24) }
  'return' { PT _ (TS _ 25) }
  'true' { PT _ (TS _ 26) }
  'void' { PT _ (TS _ 27) }
  'while' { PT _ (TS _ 28) }
  '{' { PT _ (TS _ 29) }
  '||' { PT _ (TS _ 30) }
  '}' { PT _ (TS _ 31) }

L_integ  { PT _ (TI $$) }
L_doubl  { PT _ (TD $$) }
L_Id { PT _ (T_Id _) }


%%

Integer :: { Integer } : L_integ  { (read ( $1)) :: Integer }
Double  :: { Double }  : L_doubl  { (read ( $1)) :: Double }
Id    :: { Id} : L_Id { Id (mkPosToken $1)}

Program :: { Program }
Program : ListDef { CMM.Abs.PDefs $1 }
Def :: { Def }
Def : Type Id '(' ListArg ')' '{' ListStm '}' { CMM.Abs.DFun $1 $2 $4 (reverse $7) }
ListStm :: { [Stm] }
ListStm : {- empty -} { [] } | ListStm Stm { flip (:) $1 $2 }
ListDef :: { [Def] }
ListDef : Def { (:[]) $1 } | Def ListDef { (:) $1 $2 }
ListArg :: { [Arg] }
ListArg : {- empty -} { [] }
        | Arg { (:[]) $1 }
        | Arg ',' ListArg { (:) $1 $3 }
ListId :: { [Id] }
ListId : Id { (:[]) $1 } | Id ',' ListId { (:) $1 $3 }
ListExp :: { [Exp] }
ListExp : {- empty -} { [] }
        | Exp { (:[]) $1 }
        | Exp ',' ListExp { (:) $1 $3 }
Type :: { Type }
Type : 'bool' { CMM.Abs.Tbool }
     | 'double' { CMM.Abs.Tdouble }
     | 'int' { CMM.Abs.Tint }
     | 'void' { CMM.Abs.Tvoid }
Arg :: { Arg }
Arg : Type Id { CMM.Abs.ADecl $1 $2 }
Stm :: { Stm }
Stm : Exp ';' { CMM.Abs.SExp $1 }
    | Type ListId ';' { CMM.Abs.SDecl $1 $2 }
    | Type Id '=' Exp ';' { CMM.Abs.SInit $1 $2 $4 }
    | 'return' Exp ';' { CMM.Abs.SReturn $2 }
    | 'while' '(' Exp ')' Stm { CMM.Abs.SWhile $3 $5 }
    | '{' ListStm '}' { CMM.Abs.SBlock (reverse $2) }
    | 'if' '(' Exp ')' Stm 'else' Stm { CMM.Abs.SIfElse $3 $5 $7 }
Exp6 :: { Exp }
Exp6 : Integer { CMM.Abs.EInt $1 }
     | Double { CMM.Abs.EDouble $1 }
     | 'true' { CMM.Abs.ETrue }
     | 'false' { CMM.Abs.EFalse }
     | Id { CMM.Abs.EId $1 }
     | Id '(' ListExp ')' { CMM.Abs.ECall $1 $3 }
     | Id '++' { CMM.Abs.EPIncr $1 }
     | Id '--' { CMM.Abs.EPDecr $1 }
     | '++' Id { CMM.Abs.EIncr $2 }
     | '--' Id { CMM.Abs.EDecr $2 }
     | '(' Exp ')' { $2 }
Exp5 :: { Exp }
Exp5 : Exp5 '*' Exp6 { CMM.Abs.EMul $1 $3 }
     | Exp5 '/' Exp6 { CMM.Abs.EDiv $1 $3 }
     | Exp6 { $1 }
Exp4 :: { Exp }
Exp4 : Exp4 '+' Exp5 { CMM.Abs.EAdd $1 $3 }
     | Exp4 '-' Exp5 { CMM.Abs.ESub $1 $3 }
     | Exp5 { $1 }
Exp3 :: { Exp }
Exp3 : Exp4 '<' Exp4 { CMM.Abs.ELt $1 $3 }
     | Exp4 '>' Exp4 { CMM.Abs.EGt $1 $3 }
     | Exp4 '<=' Exp4 { CMM.Abs.ELEq $1 $3 }
     | Exp4 '>=' Exp4 { CMM.Abs.EGEq $1 $3 }
     | Exp4 '==' Exp4 { CMM.Abs.EEq $1 $3 }
     | Exp4 '!=' Exp4 { CMM.Abs.ENEq $1 $3 }
     | Exp4 { $1 }
Exp2 :: { Exp }
Exp2 : Exp2 '&&' Exp3 { CMM.Abs.EAnd $1 $3 } | Exp3 { $1 }
Exp1 :: { Exp }
Exp1 : Exp1 '||' Exp2 { CMM.Abs.EOr $1 $3 } | Exp2 { $1 }
Exp :: { Exp }
Exp : Id '=' Exp { CMM.Abs.EAss $1 $3 } | Exp1 { $1 }
{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map (id . prToken) (take 4 ts))

myLexer = tokens
}
