-- lecture 1
-- exercise 1
laengde :: (Num p) => [a] -> p
laengde [] = 0
laengde (x:l) = 1 + (laengde l)
myList = [2,3,17,9,69,484000]
ex1 = laengde myList

-- exercise 2
-- :t laengde
-- > laengde :: Num p => [a] -> p

-- exercise a
qsort :: (Ord a) => [a] -> [a]

qsort [] = []
qsort (x:xs) = big ++ [x] ++ small
                 where small = qsort [a | a <- xs, a <= x]
                       big   = qsort [a | a <- xs, a > x]

-- yes it makes sense, "something" is a string, but a string is just an array of chars, meaning it can have a numeric represenation and thus be sorted

-- exercise b
-- The algorithm now does not support multiple of the same number

-- lecture 2
factorial n = product [1..n]

-- prep
-- exercise 1
myProduct :: Num a => [a] -> a
myProduct [] = 0
myProduct (x:xs) = x*(myProduct xs)

-- exercise 2
second :: [a] -> a
second xs = xs !! 1

-- lecture
-- exercise 1
allButSecond :: [a] -> [a]
allButSecond xs = head xs : tail (tail xs)

-- exercise 2
midtover :: [a] -> ([a], [a])
midtover xs = (ys, zs)
    where
        len = length xs
        index = div len 2
        ys = take index xs
        zs = drop index xs

-- exercise 3
{-
bingo (x,y) = x mod z
where
z = y + 42
-}
bingo (x, y) = x `mod` z
    where
        z = y + 42

-- lecture 3
-- prep
quango :: a -> [a]
quango n = [n]
tango :: Num p1 => (a, b) -> p2 -> p1
tango (_, _) _ = 1

{--
(\x.xy)(\z.(\u.uu))
(\z.(\u.uu))y
(\u.uu)
--}

-- lecture exercises
-- exercise 1
twice :: (a -> a) -> a -> a
twice f x = f (f (x))

twicetwo :: (a -> a, a) -> a
twicetwo (f,x) = f (f (x))

-- exercise 2
{--
initial expression:
(\x.xx)(\x.xx)
alpha reduction:
(\x.xx)(\y.yy)
beta reduction:
(\y.yy)(\y.yy)
conclusion:    This never terminates
--}

-- exercise 3
dingo :: (x, x) -> [x]
dingo (x,y) = [x,y]
-- the reason this is correct is that a list can only have one type, so the tuple MUST be specified to have the same type in both the first and second place.

-- exercise 4
-- the implementation would look kinda like this:
{--
bighead :: [Ord] -> Ord
bighead xs = length [item | item <- xs, item > head xs]
lets check the haskell interpreter:
--}
bighead xs = length [item | item <- xs, item > head xs]
{--
Close, i forgot that the function returned the amount, not the actual elements
--}

-- exercise 5
-- skipping, i didn't take a class in formal semantics...

-- exercise a
mango :: Num a => a -> a -> a -> a
mango x y z = x * y * z - 42

-- exercise b
bingo' :: a -> a
bingo' a = a
-- yes bingo is polymorphic, it can take any type of argument, be it a list, a string, a char, a boolean or even a data

myVar = bingo' [(1,2,3,False), (undefined, 0,0, True)]

-- exercise c
thesame :: Eq a => [(a,a)] -> [(a,a)]
thesame [] = []
thesame ((a,b):xs)  | a == b    = (a,b) : thesame xs
                    | otherwise = thesame xs

-- exercise d
{--
scuffedList :: [Num -> Num -> Num] 
scuffedList = [(+), (*), (+), (-)]
--}
scuffedList :: Num a => [a -> a -> a]
scuffedList = [(+), (*), (+), (-)]

-- exercise e
-- map :: (a -> b) -> [a] -> [b]

-- exercise f
myExpression :: (Ord a1, Eq a2) => a2 -> a2 -> (a1, a1) -> a1
myExpression eq1 eq2 (ord1, ord2)   | eq1 == eq2    = ord1
                                    | otherwise     = ord2

-- exercise g
madras :: (x -> x -> x,x,x) -> x
madras (f,x,y) = f (f x x) y

madrasCurried :: (t -> t -> t) -> t -> t -> t
madrasCurried f x = f (f x x)

-- lecture 4
-- pre lecture exercises
-- exercise 1
onlytwo :: [a] -> Bool
onlytwo [] = False
onlytwo [_] = False
onlytwo [_,_] = True
onlytwo _ = False

-- exercise 2
alldots :: Num a => [(a,a)] -> [(a,a)] -> [a]
alldots list1 list2 = [a*c+b*d | (a,b) <- list1, (c,d) <- list2]

-- lecture exercises
-- exercise 1
sevens :: Integral a => a -> [a]
sevens k = [n | n <- [0..k], mod n 7 == 0]

-- exercise 2
pyt :: Integral a => a -> [(a,a,a)]
pyt k = [(a, b, c) | a <- [0..k], b <- [0..k], c <- [0..k], a <= b && b < c, a*a + b*b == c*c]

-- exercise 3
-- Eq a => [a] -> Bool
headsup x = if head x == head (tail x) then True else False

-- exercise 4
plonk :: Num a => a -> a -> a -> a
plonk x y z = x+y+z

plonk' :: Num a => a -> a -> a -> a
plonk' =  \x -> \y -> \z -> x+y+z

-- exercises 5
myExpression' :: (Ord a1, Eq a2) => a2 -> a2 -> (a1, a1) -> a1
myExpression' eq1 eq2 (ord1, ord2) = if eq1 == eq2 then ord1 else ord2

-- exercise a
flop :: [(a,b)] -> [(b,a)]
flop [] = []
flop ((a,b):xs) = (b,a):flop xs

-- exercise b
dupli :: [a] -> [a]
dupli [] = []
dupli (x:xs) = x : x : dupli xs

-- exercise c
isperfect :: Int -> Bool
isperfect n = sum [k | k <- [1..n-1], mod n k == 0] == n

-- exercise d
-- see lecture 3 exercise 4

-- exercise e
sums m n = [x+y | x <- [1..m], y <- [1..n]]

sums' m n = concat [[x+y | x <- [1..m]] | y <- [1..n]]

-- lecture 5
-- pre lecture exercises
-- exercise 1
replicate' :: Int -> a -> [a]
replicate' 0 _ = []
replicate' n x = x : replicate' (n-1) x

-- exercise 2
improve' :: [a] -> [a]
improve' [] = []
improve' [x] = [x]
improve' (x1:(x2:xs)) = x1 : improve' xs

-- lecture exercises
-- exercise 1
rev :: [a] -> [a]
rev [] = []
rev [a] = [a]
rev (x:xs) = rev xs ++ [x]

-- exercise 2
mylast :: [a] -> a
mylast [a] = a
mylast (x:xs) = mylast xs

-- exercise 3
isolate :: Eq a => [a] -> a -> ([a], [a])
isolate [] _ = ([], [])
isolate (x:xs) k | x == k    = (remainder, x:isolated)
                 | otherwise = (x:remainder, isolated)
    where
        (remainder, isolated) = isolate xs k

-- exercise 4
wrapup :: Eq a => [a] -> [[a]]
wrapup [] = []
wrapup [a] = [[a]]
wrapup (x:xs) = isolated : wrapup remainder
    where
        (remainder, isolated) = isolate (x:xs) x

-- exercise 5
{--
triples :: Num a => [(a,a,a)] -> ([a], [a], [a])
triples [] = ()
triples [(a,b,c)] = ([a], [b], [c])
triples (x:xs, y:ys, z:zs) = [x,y,z] : Triples [(xs,ys,zs)]
--}

triples :: [(a, b, c)] -> ([a], [b], [c])
triples [] = ([], [], [])
triples ((a,b,c):xs) = (a:as, b:bs, c:cs)
    where
        (as, bs, cs) = triples xs

-- exercise a
rle :: Eq a => [a] -> [(a, Int)]
rle [] = []
rle (x:xs) = (x, cnt) : rle next
    where
        getCnt :: Eq a => a -> [a] -> [a]
        getCnt _ [] = []
        getCnt y (x:xs) | x == y    = x:getCnt y xs
                        | otherwise = []
        cnt = length (getCnt x (x:xs))

        getNext :: Eq a => a -> [a] -> [a]
        getNext _ [] = []
        getNext y (x:xs) | y == x    = getNext y xs
                         | otherwise = x:xs
        next = getNext x (x:xs)

-- exercise b
amy :: (a -> Bool) -> [a] -> Bool
amy _ [] = False
amy p (x:xs) = p x || amy p xs

-- exercise c
frequencies :: String -> [(Char, Int)]
frequencies "" = []
frequencies (x:xs) = (x, cnt) : frequencies remainder
    where
        cnt = 1 + length [x' | x' <- xs, x' == x]
        remainder = [x' | x' <- xs, x' /= x]

-- lecture 6
-- pre lecture
-- exercise 1
positions :: Enum a => [a] -> [Int]
positions = map (\x -> fromEnum x - 96)

-- exercise 2
sumsq :: Integral a => a -> a
sumsq n = foldr (\x -> (\y -> x + (y * y))) 0 [1..n]

-- lecture exercises
-- exercise 1

-- lecture 7
-- video stuff
type Coordinate = (Int, Int)
flip :: Coordinate -> Coordinate
flip (x,y) = (y,x)

abs' :: Coordinate -> Coordinate
abs' (x,y) = (x', y')
    where
        x' | x >= 0    = x
           | otherwise = -x
        y' | y >= 0    = y
           | otherwise = -x


type Complex = (Int, Int)
addComplex :: Complex -> Complex -> Complex
addComplex (r, i) (r', i') = (r+r', i+i')

subComplex :: Complex -> Complex -> Complex
subComplex (r, i) (r', i') = (r-r', i-i')

multComplex :: Complex -> Complex -> Complex
multComplex (a, b) (c, d) = (a*c - b*d, a*d + b*c)

divComplex :: Complex -> Complex -> Complex
divComplex (a,b) (c,d) = (div (a*c + b*d) (c * c + d * d), div (b * c - a * d) (c * c + d * d))

printComplex :: Complex -> IO ()
printComplex (r, i) = putStrLn $ "" ++ show r ++ sign ++ show abs ++ "i"
    where
        sign | i >= 0    = "+"
             | otherwise = "-"
        abs  | i >= 0    = i
             | otherwise = -i

data Direction = Right' | Left' | Up | Down

flipDirection :: Direction -> Direction
flipDirection Right' = Left'
flipDirection Left' = Right'
flipDirection Up = Down
flipDirection Down = Up

data Container = Human Int | Animal Float Float
convertContainer :: Container -> Container
convertContainer (Human x) = Animal 1.0 1.0
convertContainer (Animal x y) = Human 1

-- pre lecture
-- exercise 1
data Unary = Z | I Unary
unary2int :: Unary -> Integer
unary2int Z = 0
unary2int (I u) = 1 + unary2int u


-- exercise 2
data Tree a = Leaf a | Node (Tree a) a (Tree a)

least :: (Ord a) => Tree a -> a
least (Leaf a) = a
least (Node a b c) = value
    where
        value | b <= least a && b <= least c = b
              | least a >= least c           = least c
              | otherwise                    = least a

-- lecture exercises
-- exercise 1
data Aexp = N Int | X String | Add Aexp Aexp | Mult Aexp Aexp

-- exercise 2
type Assoc k v = [(k, v)]
find :: (Eq a) => a -> [(a, v)] -> v
find k ((k', v'):xs) | k == k'   = v'
                     | otherwise = find k xs

eval :: Aexp -> Assoc String Int -> Int
eval (Mult e1 e2) lst = (eval e1 lst) * (eval e2 lst)
eval (N v) lst = v
eval (X v) lst = find v lst
eval (Add e1 e2) lst = (eval e1 lst) + (eval e2 lst)

-- exercise 3
data File = Root String [File]
          | Directory String [File]
          | File String String
-- This solution makes a lot more sense because what does a directory do? what is a directory? a directory is essentially a file, so i renamed it.
-- My file data type can be either a directory or a file, a directory has two parameters, its parent and its children, a file has two, its parent and its content

filesystem = Root "/" [Directory "usr" [], Directory "srv" [], Directory "etc" [], Directory "boot" [File "kernel" "some-binary-data"]]

-- exercise 4
data Tree' a = Leaf' a | Empty' | Node' (Tree' a) a (Tree' a) deriving Show
leaves :: Tree' a -> Int
leaves (Leaf' _) = 1
leaves Empty' = -1
leaves (Node' a v b) = 1 + leaves a + leaves b

insert :: Tree' a -> a -> Tree' a
insert Empty' x = Leaf' x
insert (Leaf' a) x = Node' (Leaf' x) a Empty'
insert (Node' Empty' v Empty') x = Node' (Leaf' x) v Empty'
insert (Node' y v Empty') x = Node' y v (Leaf' x)
insert (Node' a b c) x | leaves a > leaves c = Node' a b (insert c x)
                       | otherwise           = Node' (insert a x) b c

-- exercise 5
type InVector = (Int,Int)

(&&&) :: InVector -> InVector -> InVector
(x1, y1) &&& (x2, y2) = (x1 + x2, y1+y2)

(***) :: InVector -> InVector -> Int
(x1, y1) *** (x2, y2) = (x1*x2) + (y1*y2)

-- exercise a

balanced :: Tree' a -> Bool
balanced (Leaf' _) = True
balanced Empty' = True
balanced (Node' a v b) | leaves a == leaves b     = True
                       | leaves a == leaves b - 1 = True
                       | leaves a == leaves b + 1 = True
                       | otherwise                = False

-- exercise b
data Prop = Const Bool
          | Var Char
          | Not Prop
          | And Prop Prop
          | Imply Prop Prop
          deriving Show

p1 :: Prop
p1 = And (Var 'A') (Not (Var 'A'))

p2 :: Prop
p2 = Imply (And (Var 'A') (Var 'B')) (Var 'A')

p3 :: Prop
p3 = Imply (Var 'A') (And (Var 'A') (Var 'B'))

p4 :: Prop
p4 = Imply (And (Var 'A') (Imply (Var 'A') (Var 'B'))) (Var 'B')

{--
    A       |   B       |   A -> B      |   B -> A      |   (A && B) -> A   |   (A && (A -> B)) -> B
    T       |   T       |   T           |   T           |   T               |   T
    T       |   F       |   F           |   T           |   T               |   T
    F       |   T       |   T           |   F           |   T               |   T
    F       |   F       |   T           |   T           |   T               |   T
--}


type Subst = Assoc Char Bool

eval' :: Subst -> Prop -> Bool
eval' _ (Const b) = b
eval' s (Var x) = find x s
eval' s (Not p) = not (eval' s p)
eval' s (And p1 p2) = eval' s p1 && eval' s p2
eval' s (Imply p1 p2) = eval' s p1 <= eval' s p2

vars :: Prop -> [Prop]
vars (Const b) = []
vars (Var x) = [Var x]
vars (Not x) = vars x
vars (And p1 p2) = vars p1 ++ vars p2
vars (Imply p1 p2) = vars p1 ++ vars p2

equiv :: Prop -> Prop -> Bool
equiv (Const a) (Const b) = a == b
equiv (Var a) (Const b) = False
equiv (Const b) (Var a) = False
equiv (Var a) (Var b)   = False
equiv p1 p2 = all (\x -> eval' x p1 == eval' x p2) substitutions
    where
        substitutions = [[('A', True), ('B', True)], [('A', True), ('B', False)], [('A', False), ('B', True)], [('A', False), ('B', False)]]

-- exercise c
data Expr' = Val' Int
           | Add' Expr' Expr'
           deriving Show


foldexp :: (Int -> a) -> (a -> a -> a) -> Expr' -> a
foldexp f _ (Val' a) = f a
foldexp f g (Add' e1 e2) = g (foldexp f g e1) (foldexp f g e2)

eval'' :: Expr' -> Int
eval'' = foldexp id (+)

-- exercise d
data Maybe' a = Just' a | Nothing'

instance Eq a => Eq (Maybe' a) where
    Just' a == Just' b = a == b
    Nothing' == Nothing' = True
    _ == _ = False

-- exercise e
build :: [a] -> Tree' a
build [] = Empty'
build (x:xs) = insert (build xs) x

-- lecture 10
-- pre lecture
-- exercise 1
data Onion a = Core a | Layer (Onion a) deriving Show
instance Functor Onion where
    -- fmap :: (a -> b) -> Onion a -> Onion b
    fmap g (Core a) = Core (g a)
    fmap g (Layer a) = Layer (fmap g a)

-- exercise 2
checkRule1 x = (pure id <*> (Just x)) == Just x
--checkRule2 :: (Eq b) => (a -> b) -> a -> Bool
--checkRule2 g x = (pure (g x)) == (pure g <*> pure x)

-- lecture exercises
-- exercise 1
data UTree a = UNode a [UTree a] deriving Show
instance Functor UTree where
    -- fmap :: (a -> b) -> UTree a -> UTree b
    fmap g (UNode a []) = UNode (g a) []
    fmap g (UNode a xs) = UNode (g a) (map (fmap g) xs)

-- exercise 2
type R = ()

data List a = List [a] deriving Show

-- exercise 3
instance Functor List where
    fmap g (List []) = List []
    fmap g (List (x:xs)) = List (g x:map g xs)

instance Applicative List where
    -- pure :: a -> List [a]
    pure x = List [x]
    -- (<*>) :: List (a -> b) -> List a -> List b
    List (x:xs) <*> List ys = List (map x ys ++ (xs <*> ys))

-- exercise 4
prodthree :: (Num a) => [a] -> [a] -> [a] -> [a]
prodthree [] _ _ = []
prodthree _ [] _ = []
prodthree _ _ [] = []
prodthree xs ys zs = pure (\x y z -> x * y * z) <*> xs <*> ys <*> zs

-- exercise a
data Exp a = EVar a | Val Int | EAdd (Exp a) (Exp a) | EMult (Exp a) (Exp a) deriving Show

instance Functor Exp where
    -- fmap :: (a -> b) -> Exp a -> Exp b
    fmap g (EVar a) = EVar (g a)
    fmap g (Val a) = Val a
    fmap g (EAdd a b) = EAdd (fmap g a) (fmap g b)
    fmap g (EMult a b) = EMult (fmap g a) (fmap g b)

-- exercise b
instance Applicative Exp where
    -- pure :: a -> f a
    pure = EVar
    -- (<*>) :: f (a -> b) -> f a -> f b
    EVar a <*> EVar b = EVar (a b)
    EVar a <*> Val b = Val b
    EVar a <*> EAdd b c = EAdd (EVar a <*> b) (EVar a <*> c)
    EVar a <*> EMult b c = EMult (EVar a <*> b) (EVar a <*> c)
    EAdd a b <*> c = EAdd (a <*> c) (b <*> c)
    EMult a b <*> c = EMult (a <*> c) (b <*> c)

-- exercise c
type Name = String
type Env = [(Name, Int)]
fetch :: Name -> Env -> Int
fetch x env = case lookup x env of
    Nothing -> error "invalid name"
    Just v -> v

eEval :: Exp Name -> Env -> Int
eEval (EVar e) env = find e env
eEval (Val e) env = e
eEval (EAdd a b) env = eEval a env + eEval b env
eEval (EMult a b) env = eEval a env + eEval b env



-- lecture 11
-- video lecture
-- pre lecture
tuple :: Monad m => m a -> m b -> m (a,b)

-- lecture exercises
