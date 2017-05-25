module Main where

import FreeMonad.RPNExpr
    ( RPN
    , num
    , add
    , sub
    , mul
    , end
    , stringify
    , parse
    , eval
    )

main :: IO ()
main = mapM_ putStrLn
    [ "expr1: " ++ show expr1
    , "expr2: " ++ show expr2
    , "stringify expr1: " ++ expr1Str
    , "stringify expr2: " ++ expr2Str
    , "parse . stringify $ expr1: " ++ show (parse expr1Str :: Either String (RPN Double ()))
    , "parse . stringify $ expr2: " ++ show (parse expr2Str :: Either String (RPN Double ()))
    , "eval expr1: " ++ show (eval expr1)
    , "eval expr2: " ++ show (eval expr2)
    , "eval $ expr1 >> expr2: " ++ show value
    ]

expr1 :: RPN Double ()
expr1 = do
    num 8
    num 6
    num 1
    sub
    mul

expr2 :: RPN Double ()
expr2 = do
    num 2
    add
    end

expr1Str :: String
expr1Str = stringify expr1

expr2Str :: String
expr2Str = stringify expr2

value :: Either String Double
value = do
    expr <- parse . stringify $ expr1 >> expr2
    eval expr
