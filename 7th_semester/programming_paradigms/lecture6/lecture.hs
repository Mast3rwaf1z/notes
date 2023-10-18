-- prelecture
positions :: Enum a => [a] -> [Int]
positions a = map (subtract (subtract 1 (fromEnum 'a')) . fromEnum) a 

--positions1 a = map (subtract 96 . fromEnum) a

-- foldr takes three arguments, a function to be mapped, a starting value and a list to operate on.
sumsq :: (Enum b, Floating b) => b -> b
sumsq n = foldr (+) 0 [x ** 2 | x <- [1..n]]

-- lecture
-- ex1
within :: Ord a => [a] -> (a, a) -> [a]
within a (start, end) = filter (>= start) (filter (<= end) a)

-- ex2
sumrows :: (Foldable t, Num b) => [t b] -> [b]
sumrows = map (foldr (+) 0)

-- ex3
fact :: (Num a, Enum a) => a -> a
fact k = product [1 .. k]

approx n = foldr (+) 0 (map (\a -> 1 / (fact a)) [0..n])

-- ex4

-- fingo xs ys = foldr (:) xs ys
-- this function just concatenates xs onto ys

-- ex5
-- the type of map map is probaby something like: (a -> b) -> [[a]] -> [[b]]
-- the actual type is [a -> b] -> [[a] -> [b]]

-- ex a
partition p xs = (filter (\i -> p i) xs, filter (\i -> not (p i)) xs)

partitionFoldr p xs = (foldr ((:) . (\i -> p i)) xs, foldr ((:) . (\i -> not (p i))) xs)

-- ex b
