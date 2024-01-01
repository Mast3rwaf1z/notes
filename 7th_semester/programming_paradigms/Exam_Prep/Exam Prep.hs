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
data File = Root String [File] | Directory String [File] | File String String
-- This solution makes a lot more sense because what does a directory do? what is a directory? a directory is essentially a file, so i renamed it.
-- My file data type can be either a directory or a file, a directory has two parameters, its parent and its children, a file has two, its parent and its content

filesystem = Root "/" [Directory "usr" [], Directory "srv" [], Directory "etc" [], Directory "boot" [File "kernel" "some-binary-data"]]

-- exercise 4
data Tree' a = Leaf' a | Empty' | Node' (Tree' a) a (Tree' a) deriving Show
insert :: Ord a => Tree' a -> a -> Tree' a
insert Empty' x = Leaf' x
insert (Leaf' a) x = Node' (Leaf' x) a Empty'
insert (Node' Empty' v Empty') x = Node' (Leaf' x) v Empty'
insert (Node' y v Empty') x = Node' y v (Leaf' x)
insert (Node' a b c) x = Node' (insert a x) b c