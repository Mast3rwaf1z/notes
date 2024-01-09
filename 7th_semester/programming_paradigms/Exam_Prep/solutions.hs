{- 
Full name:      Thomas Møller Jensen
AAU Mail:       tjen19@student.aau.dk
Study Number:   somthing
-}

-- Problem 1 - 18 Points

{-
allAnswers f [] = Just []
allAnswers f (x:xs) = let fun = f x
    in 
        if (fun == Nothing) then Nothing
        else x: (allAnswers f xs)
            where
                x = x
-}
-- Problem 1.1
-- maybe values are used, so i'd always use a do block
-- useless where
-- line 14 concatenates x to a recursion as the result of the function, x is of type a, while the function returns Maybe a, its a type error

-- Problem 1.2
-- *sigh*
highAllAnswers :: (a -> Maybe b) -> [a] -> Maybe [b]
highAllAnswers f [] = Just []
highAllAnswers f xs = if 
    all (\x -> 
        case x of 
            Nothing -> False 
            Just x -> True) (map f xs) then Nothing else Just [x | (Just x) <- (map f xs)]

-- Problem 1.3
-- this is easiest to do in a do block in my opinion
allAnswers :: (a -> Maybe b) -> [a] -> Maybe [b]
allAnswers f [] = Just []
allAnswers f (x:xs) = do
    y <- f x
    ys <- allAnswers f xs
    return (y:ys)

testAllAnswers = allAnswers (\x -> Just (x*2)) [1,2,3,4]

-- Problem 2 - 14 Points
-- Problem 2.1
a :: Eq a1 => a2 -> (a1, a1) -> [a2]
a a2 (a11, a12) = if a11 == a12 then [a2] else []

b :: Eq a => (a -> a -> Bool) -> Bool -> a -> a -> Bool
b f bool a1 a2 = f a1 a2 == bool

c :: Show a => a -> IO b -> IO b
c showable retvar = do
    putStrLn (show showable)
    retvar

d :: (a -> b) -> a -> a -> [b]
d f a1 a2 = [f a1, f a2]

-- Problem 2.2
-- d is parametric polymorphism
-- a b and c is ad hoc polymorphism
-- i think c can be seen as parametric polimorphism? a just has to be showable, you can declare your type to be showable...

-- Problem 3 - 16 Points
-- Problem 3.1
data Tree a = Leaf a | Node (Tree a) (Tree a)

treeTest = Node (Leaf "dog") (Node (Leaf "cat") (Leaf "hamster"))

-- Problem 3.2
-- if i had time it would be more fun to implement it as a monad and pass min and max to it, but alas, this is what we get
minimax :: Ord a => Tree a -> (a, a)
minimax tree = (minimum (result tree), maximum (reverse (result tree)))
    where
        result tree = case tree of
            Leaf a -> [a]
            Node a b -> (result a) ++ (result b)

minimaxTest = treeTest

-- Problem 4 - 14 Points
-- Problem 4.1
echoDo :: IO ()
echoDo = do
    putStr "Please type a word: "
    s <- getLine
    putStrLn ("You typed " ++ s)

echo :: IO ()
echo = putStr "Please type a word: " >>= \_ ->
       getLine                     >>= \s ->
       putStrLn ("You typed " ++ s)

-- Problem 4.2
-- do last

seconds :: IO ()
seconds = do
    values <- getLine
    let booleanList = read values :: [(Bool, Bool)]
    putStrLn (show ([x | (_, x) <- booleanList]))


-- Problem 5 - 18 Points
-- Problem 5.1
-- This is not allowed as a list is a data type that only takes one type parameter, something like this:
-- data [] a = [] | a : [a]

-- Problem 5.2
data Alternating a b = Even a | Odd b deriving Show

-- Problem 5.3
seperate :: [Alternating a b] -> ([a], [b])
seperate [] = ([], [])
seperate  ((Even a):xs) = (a:as, bs)
    where
        (as, bs) = seperate xs
seperate ((Odd b):xs) = (as, b:bs)
    where
        (as, bs) = seperate xs

-- Problem 5.4
infinite :: [Alternating Integer String]
infinite = [if y then Even x else Odd ['a' | _ <- [1..x]] | x <- [1..], y <- [True, False]]

-- Problem 6 - 18 Points
newtype ToPairs a = TP (a,a)
-- Problem 6.1
ex611 :: ToPairs Bool
ex611 = TP (True, True)

ex612 :: ToPairs ((Maybe Int) -> Int)
ex612 = TP (f, f)
    where
        f (Just a) = a
        f Nothing = 0

-- Problem 6.2
instance Functor ToPairs where
    fmap f (TP (x, y)) = TP (f x, f y)

instance Applicative ToPairs where
    pure a = TP (a, a)
    TP (a, b) <*> TP (c, d) = TP (a c, b d)