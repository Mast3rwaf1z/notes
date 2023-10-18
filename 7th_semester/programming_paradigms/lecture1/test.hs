module Main where

test n = if n < 100 then test (n * 2) else n 


main = print(test 2)