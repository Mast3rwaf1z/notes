
-- prelecture

-- Exercise 1
{--
    THis function takes a monad a and b, and returns a monad of a tuple
--}
tuple :: Monad m => m a -> m b -> m (a, b)
tuple x y = 
    x >>= \n ->
    y >>= \m ->
    return (n, m)

-- In this case the lambda expressions are replaced by a do block.
-- The first two lines in the do block calls the bind operator on each of the argument monads.

tupleDo :: Monad m => m a -> m b -> m (a, b)
tupleDo x y = do
    n <- x
    m <- y
    return (n, m)

-- Exercise 2
-- This exercise takes the following function in a do block
ex2_orig s f z = do
    y <- z
    s y
    return (f y)

-- and wants it without the do notation:
ex2 s f z = 
    z >>= \y -> 
    s y >>= \_ ->
    return (f y)

-- Lecture

-- Exercise 1
-- we have a function:
fourfirst xs = do
    x <- xs
    return (4, x)

-- since the list monad applies the function fourfirst to each element of the list
-- the definition of the list monad:

{--
instance Monad [] where
    xs >>= f = [y | x <- xs, y <- f x]
--}

-- applicationOfFourFirst = fourfirst [1,2,3,4]
-- > [(4, 1), (4, 2), (4, 3), (4, 4)]

-- Exercise 2
data W x = Bingo x deriving Show

instance Functor W where
    fmap f (Bingo x) = Bingo (f x)


instance Monad W where
    return = Bingo
    Bingo x >>= f = f x


instance Applicative W where
    pure = Bingo
    Bingo y <*> Bingo x = Bingo (y x)

wrapadd :: Num b => b -> W b -> W b
wrapadd x y = do
    v1 <- y
    Bingo (x+v1)

h :: (Monad m, Num b) => m b -> m b -> m b
h x y = do
    v1 <- x
    v2 <- y
    return (v1*v2)

-- Exercise 3

data Tree a = Leaf a | Node (Tree a) (Tree a)

-- This is the wrong idea
--instance Functor Tree where
--    fmap f (Leaf a) = Leaf (f a)
--    fmap f (Node a b) = Leaf (fmap f a + fmap f b)


-- Exercise a

--foldM :: Monad m => (t1  -> t2 -> m t2) -> [t1] -> t2 -> m t2

main = print (h (h (Bingo 4) (Bingo 2)) (wrapadd 10 (Bingo 2)))