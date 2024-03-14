--type Tree = (Int,[Tree]) is not allowed, recursive types are not allowed


--ex 1
-- defining a type Aexp that can be an integer, a string, an addition between Aexp and Aexp, and multiplication of Aexp and Aexp
data Aexp = Int Integer | Str String | Plus Aexp Aexp | Times Aexp Aexp


--ex 2
-- type:

type Assoc k v = [(k, v)]

-- example:
find :: Eq k => k -> Assoc k v -> v
find k t = head [v | (k', v) <- t, k == k']

--eval :: Eq n => Aexp -> Assoc k n -> n

--eval (Int n) = n

--ex 3
