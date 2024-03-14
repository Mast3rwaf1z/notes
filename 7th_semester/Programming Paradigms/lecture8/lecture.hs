-- problem 1

problem11 :: (Ord a, Num a) => a -> a -> [[Bool]] -> Bool

problem11 a b xs = a+a > b && head (head xs)

--problem12 :: Num a => (t -> a,t) -> a -> a
problem12 (l, b) a = l b - a

--problem13
--problem13 :: Fractional t1 => (t2 -> t1) -> (t2 -> t1) -> (t1 -> t3) -> t2 -> t3
problem13 f1 f2 f3 a = ((f1 a)/2 + (f2 a)/2 + (f3 a/2))

-- problem 2
triples :: [(a,b,c)] -> ([a], [b], [c])

-- problem 3
triples [] = ([], [], [])
triples ((x,y,z):ts) = (xs, ys, zs)
    where
        xs = x : [x | (x,_,_) <- ts]
        ys = y : [y | (_,y,_) <- ts]
        zs = z : [z | (_,_,z) <- ts]


-- problem 4
--cfrac :: Num a => a -> [a]
--cfrac x n = [n] : 1/(cfrac x (n-1))

-- problem 5
--type Vector = [Int]

--test :: Vector v => v -> n
--test vector = 1

class InVector v where
    (&&&) :: v -> v -> v
    (***) :: v -> v -> Integer

instance InVector Bool where
    (&&&) a b = True
    (***) a b = 10





-- problem a

--unique chr:str = 

--frequencies :: (String s, Num b) => s -> [(a, b)]
frequencies str = [(char, count) | char <- chars, count <- counts]
    where
        counts = [length [char1 | char1 <- str, char1 == char2] | char2 <- str]
        chars = str