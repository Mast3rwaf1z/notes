-- prep
data Onion a = Core a | Layer (Onion a)

instance Functor Onion where
    fmap f (Core a) = Core (f a)
    fmap f (Layer a) = Layer (fmap f a)


-- lecture
-- exercise 1
data UTree a = Node a [UTree a] 

instance Functor UTree where
    fmap f (Node a xs) = Node (f a) (fmap (fmap f) xs)

-- now we can map to this datatype:
-- fmap (*2) (Node 10 [Node 1 [], Node 2 []])


showUTree :: UTree Integer -> IO()

showUTree (Node a xs) = do
    putStrLn (show a)
    each xs
    where
        each [] = putStr ""
        each [Node b y] = putStrLn (show b)
        each ((Node b y):xs) = do
            putStrLn (show b)
            each xs

-- call this function using `showUTree (Node 10 [(Node 1 []), (Node 2 [])])`


-- ex 3

instance Functor (<*>) where
    fmap f xs = [f x | x <- xs]

test = [(+1)] <*> [1,2]

main = print test