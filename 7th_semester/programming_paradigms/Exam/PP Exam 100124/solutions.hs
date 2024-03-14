-- Name: Thomas Møller Jensen
-- AAU mail address: tjen19@student.aau.dk
-- Study number: 20193387


-- PROBLEM 1

-- 1.1
rotate :: [a] -> [a]
rotate xs = (tail xs) ++ [head xs]

-- Yes the function is polymorphic.

-- It is parametric polymorphism, this is because we pass the type of the function as a parameter to it, lets say we pass [1,2,3] to the function, then the function has the type rotate :: [Int] -> [Int], while with "eat" as argument it has type rotate :: String -> String

-- 1.2
allrotates :: [a] -> [[a]]
allrotates [] = []
allrotates xs = xs : take ((length xs) -1) (map rotate (allrotates xs))
-- using some funny lazy evaluation :)
-- here i am using map to call rotate on the result of allrotates, the take call defines how many times the rotate function should be called on each idex of the list. xs is concatenated at the start of the list, it doesn't matter where, but xs is also a rotation of itself, so it makes sense to concatenate it here instead of doing the rotation.

-- 1.3
allrotates' :: [a] -> [[a]]
allrotates' xs = map (rotateN xs) [0..((length xs)-1)]
    where
        rotateN :: [a] -> Int -> [a]
        rotateN xs' 0 = xs'
        rotateN xs' n = rotateN (rotate xs') (n-1)
-- allrotates' is defined here using a helper function rotateN that calls rotate n times on xs', it then calls map with this helper function on a list of integers representing the amount of times it should call rotate.

-- PROBLEM 2

-- 2.1
data Tree a = Node (Tree a) (Tree a) | LNode a (Tree a) (Tree a) | Leaf a deriving Show
-- a partial tree is best described using this data type as one that contains Node types. it can have none, but in that case it is ALWAYS a fully labeled tree, as the rest can only be LNodes or Leafs. An LNode is a node which has a label.

t1 :: Tree Int
t1 = Node (Node (Leaf 17) (Leaf 484000)) (Leaf 1964)

t2 :: Tree String
t2 = LNode "bingo" (Leaf "plip") (LNode "plop" (Leaf "uhu") (Leaf "fedtmule"))

-- 2.2
isFull :: Tree a -> Bool
isFull (Node _ _) = False
isFull (Leaf _) = True
isFull (LNode _ a b) = isFull a && isFull b
-- isFull pattern matches on the possible types of the tree, if a node is pattern matched anywhere in the tree, it just returns false, otherwise we call isFull recursively on LNodes and if any of the recursions are false, the function will return false, and return true on Leaf's.

-- 2.3
-- unsure if i am allowed to pattern match this, if i have time come back and see if i can improve
preorder :: Tree a -> Maybe [a]
preorder (Node _ _) = Nothing
preorder (Leaf a) = Just [a]
preorder (LNode v a b) = do
    justa <- preorder a
    justb <- preorder b
    return (v : (justa ++ justb))

-- since we're using maybe, then binding in do blocks results in Nothing if any of the binds result in Nothing, making this an easy solution, i pattern match on Node and Leaf, as they are always the same result, and let the maybe monad determine the maybe value of a and b, then i concatenate the lists at the end

-- PROBLEM 3

-- 3.1
remove :: String -> String -> String
remove first second = [x | x <- second, length ([y | y <- first, (y == x)]) == 0]
-- really inefficient solution, but hey it works...
-- it takes a first and second argument, where the list comprehension generates from the second argument, and checks a predicate. the predicate takes the length of a list of common values in first and second and checks whether its 0 or not, if it is 0, add the value of second to the final list.

-- 3.2
remove' :: String -> String -> String
remove' _ [] = ""
remove' first (x:xs) = if inList x first then remove' first xs else x : remove' first xs
    where
        inList x [] = False
        inList x (y:ys) = x == y || inList x ys
-- Here i had to define a helper function to find out whether a value is in a list, then i have an if statement applying the inList function, if its true do not concatenate x, and do recursion, if its false, concatenate x and do recursion


-- PROBLEM 4
newtype WrapString a = WS (a, String) deriving Show
instance Functor WrapString where
    fmap f (WS (x,s)) = WS (f x, s)

-- 4.1

instance Applicative WrapString where
    pure a = WS (a, "")
    (WS (a, _)) <*> (WS (b, s)) = (WS ((a b), s))
-- This applicative takes a WS value with a function as its type for a, and applies it to the value of the second argument of <*>, returning it with the string of the second arguments WS value

-- 4.2
instance Monad WrapString where
    return = pure
    (WS (a, b)) >>= f = f a
-- This monad just applies a function f to the parameter a as seen in the definition of WS

-- 4.3
pairup :: WrapString a -> WrapString b -> WrapString (a,b)
pairup (WS (a, s)) second = do
    y <- second
    WS ((a,y), s)
-- this function creates a do block, but i needed the string component of the first argument so i pattern match it, then i bind the value of second to the variable y, and construct a new WrapString value

-- PROBLEM 5

-- 5.1
p51 :: (Ord a, Num a) => a -> a -> a -> (a, a)
p51 a1 a2 a3 = if a1 > a2 && a2 > a3 then (a1, a2) else (a2, a3)

-- It's polymorphic, this is because its declared as Ord and Num, Ord just means it can be ordered, and as such the > and < operators exist, while Num involves Float and Integer among others.
-- its ad hoc polymorphism, as the overloaded types are defined for this function

-- 5.2
p52 :: [(Integer, p -> Char)]
p52 = [(1, \t -> 'x')]

-- it is polymorphic, t does not have a declared type, so its parametric polymorphism, p does not have an overloaded type

-- 5.3
p53 :: (t1 -> Bool -> t2) -> t1 -> t2
p53 f x = f x True

-- It is polymorphic, only one of the arguments have a declared type. Its parametric polymorphism as t1 and t2 does not have an overloaded type

-- 5.4
p54 :: (Num a, Enum a) => [a]
p54 = [1,2,3,4]

-- it is polymorphic, like with 5.1 it has Num defined and Enum defined, enum just requires it to be a number.
-- ad hoc polymorphism as the types are defined for a

-- PROBLEM 6

-- 6.1
-- easy, lazy evaluation
naturals :: [Int]
naturals = 1 : (map (1 +) naturals)
-- this function just uses lazy evaluation to generate a new natural for each element, it expands to something like (1:2:3:4:5:...)

-- 6.2
facs :: [Int]
facs = map fac [0..]
    where
        fac 0 = 1
        fac n = fac (n-1) * n
-- This function facs just maps the inner function fac to an infinite list, generating the factorial of each element in the list


-- 6.3
--facs' :: [Int]
--facs' = zipWith (\xs _ -> product xs) (1 : facs') (1 : facs') 
-- 10 minutes left, i don't know why this doesn't work but i don't have time to finish it.
