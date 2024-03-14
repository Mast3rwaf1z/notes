-- ex 1
-- collatz conjecture
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use print" #-}

func = do
  putStr "Input integer: "
  w <- getLine
  loop (read w :: Int)
 where
  loop 1 = putStrLn (show 1)
  loop x = do
    putStr (show x ++ " -> ")
    if even x
      then loop (div x 2)
      else loop (3 * x + 1)

-- ex2
letters = do
  input <- getLine
  loop input
 where
  loop [] = return ()
  loop (chr : chrs) = do
    putStrLn (show chr)
    loop chrs

-- ex3
--lettersSequence = sequence_ [putStrLn (read c :: String) | c <- getChar]

lettersSequence = do
  input <- getLine
  sequence_ [putStrLn (show c) | c <- input]

-- ex4

hugorm :: IO Integer
hugorm = do
  putStr "Specify number: "
  n <- getLine
  initial <- getLine
  sum_ ((read n :: Integer) - 1) (read initial :: Integer)
 where
  sum_ 0 s = return s
  sum_ x s = do
    next <- getLine
    sum_ (x - 1) (s + (read next :: Integer))

-- ex a
sumInts :: Integer -> IO Integer
sumInts def = do
  input <- getLine
  loop def (read input :: Integer)
 where
  loop s 0 = return s
  loop s x = do
    next <- getLine
    loop (s + x) (read next :: Integer)

sumInts1 :: Integer -> IO Integer
sumInts1 def
  | def == 0 = return 0
  | otherwise = do
    input <- getLine
    return (def + (read input :: Integer))

hej = do
  putStr "Input something: "
  test <- getLine
  putStr test
  putStr " "
  putStrLn test
