data Tree a = Leaf a | Node a (Tree a) (Tree a) deriving Show

instance Functor Tree where
    -- fmap :: (a -> b) -> Tree a -> Tree b
    fmap g (Leaf a) = Leaf (g a)
    fmap g (Node a l r) = Node (g a) (fmap g l) (fmap g r)

instance Applicative Tree where
    -- pure :: a -> Tree a
    pure = Leaf
    -- (<*>) :: Tree (a -> b) -> Tree a -> Tree b
    (Leaf a) <*> (Leaf b) = Leaf (a b)
    (Node a l r) <*> (Leaf b) = Node (a b) (l <*> (Leaf b)) (r <*> (Leaf b))
    (Leaf a) <*> (Node b l r) = Node (a b) ((Leaf a) <*> l) ((Leaf a) <*> r)
    (Node a l r) <*> (Node b l' r') = Node (a b) (l <*> l') (r <*> r')
