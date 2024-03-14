-- pre lecture
--nsonly_recursive n =

-- exercise 1
x = 1 : (map (1 +) x)

-- this is wrong
-- 1: map (1+) 1: (map (1+) 1: (map (1+) 1: (map (1+) 1)))
-- 1: map (1+) 1: (map (1+) 1: (map (1+) 1,2))
-- 1: map (1+) 1: (map (1+) 1,2,3)
-- 1: map (1+) 1,2,3,4
-- 1,2,3,4,5

-- this is more correct
--    take 5 x
-- expands to
--    take 5 (1 : (map (1+) x))
-- which expands to
--    take 5 (1:2:map (1+) x)
-- which expands to
--    take 5 (1:2:3:map (1+) x)
-- ...
--    take 5 (1:2:3:4:map (1+) x)
-- ...
--    take 5 (1:2:3:4:5)
-- and results in
--    [1,2,3,4,5]
-- This is because of lazy evaluation, evalutes the expression from left to right

-- exercise 2

fibsfrom n1 n2 = n1 : fibsfrom n1 (n1 + n2)

-- exercise 3
indflet :: a -> [a] -> [a]
indflet _ [] = []
indflet _ [x] = [x]
indflet e (x : y : ys) = x : e : indflet e (y : ys)

-- the second pattern match fails, as to check whether there is only one element in the second argument, to check the length it'll have to evaluate undefined, which gives an exception

-- exercise 4
allBinaries :: [String]
allBinaries = [f x | x <- [0 ..]]
 where
  f x
    | 0 = "0"
    | 1 = "1"
    | otherwise = f (mod x 2) ++ f (div x 2)

-- exercise a
{-fibZip = fib
    where -}
