-- lecture exercises
-- ex 1
sevens :: Integral k => k -> [k]
sevens k = [x | x <- [1..k-1], mod x 7 == 0]

-- ex 2
pyt :: Integral k => k -> [(k,k,k)]
pyt k = [(a,b,c) | c <- [1..k], b <- [1..k-1], a <- [1..k], (a * a) + (b * b) == (c * c)]

-- ex 3
-- original: headup x = if head x == head (tail x) then True else False
-- the function is way too overcomplicated, you can completely remove the if statement:
headsup x = head x == head (tail x)

-- next up the type of the function could be made more generic, Num makes the functions only work on numbers, but the definition of the problem states that it can be any type that can be compared, we have the Eq type for that:
headsup :: Eq x => [x] -> Bool
-- this will support chars as well as strings (lists of chars)

-- ex 4
plonk :: Num a => a -> a -> a -> a
plonk = \x y z -> x+y+z

-- ex 5
stuff eq1 eq2 (ord1, ord2) = if y then ord1 else ord2
    where y = eq1 == eq2 && ord1 < ord2

-- ex a
flop :: [(b, a)] -> [(a, b)]
flop xs = [(e2, e1) | (e1, e2) <- xs]

-- ex b
dupli :: [a] -> [a]
dupli xs = concat [[x,x] | x <- xs]

-- ex c
isperfect :: Integral a => a -> Bool
isperfect n = sum [divisor | divisor <- [1..n-1], mod n divisor == 0] == n

-- ex d
bighead :: Ord a => [a] -> Int
bighead xs = length [x | x <- xs, x > head xs]

-- ex e
-- original: sums m n = [x+y | x <- [1..m], y <- [1..n]]
sums m n = concat [[x+y |  y <- [1..n]] | x <- [1..m]]
