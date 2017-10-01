module Head where

type Index = Int
type Id = String
data TI a = TI (Index -> (a, Index))
type Subst  = [(Id, SimpleType)]
data Assump = Id :>: SimpleType deriving (Eq, Show)

data Literal = Int | Bool | TInt Int | TBool Bool deriving (Eq)

data SimpleType  = TVar Id
                 | TArr  SimpleType SimpleType
                 | Lit Literal
                 | TCon Id
                 | TApp SimpleType SimpleType
                 deriving Eq

data Pat = PVar Id
         | PLit Literal
         | PCon Id [Pat]
         deriving (Eq, Show)

data Expr =  Var Id
            | App Expr Expr
            | Lam Id Expr
            | If Expr Expr Expr
            | Case Expr [(Pat,Expr)]
            deriving (Eq, Show)

instance Show SimpleType where
    show (TVar i) = i
    show (TArr (TVar i) t) = i++"->"++show t
    show (TArr (Lit tipo) t) = show tipo ++"->"++show t
    show (TArr t t') = "("++show t++")"++"->"++show t'
    show (TCon i) = i
    show (TApp c v) = show c ++ " " ++ show v

    show (Lit tipo) = show tipo

instance Show Literal where
    show (TInt _) = "Int"
    show (TBool _) = "Bool"
    show Int = "Int"
    show Bool = "Bool"