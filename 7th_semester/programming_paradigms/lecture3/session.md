ex1:
```hs
twice f x = f (f (x))
```
the type is defined as:
```hs
twice :: (a -> a) -> a -> a
```
because of currying, the second arrow appears, it means that the XX (fix later)
```hs
twicetwo (f, x) = f(f x)
```
here the input is a tuple, apparently not being currying...
```hs
twicetwo :: (a -> a, a) -> a
```

ex2:
$$(\lambda x.xx)(\lambda x.xx)$$
renamed:, this is $\alpha$ reduction
$$(\lambda x.xx)(\lambda y.yy)$$
$\beta$: 
$$(\lambda y.yy)(\lambda y.yy)$$
because the first has two x's as its return thingy, then we get two lambda expressions containing y, resulting in a cycle.

ex3:
```hs
dingo :: (x, y) -> [x, y]
```
this is wrong and actually makes sense after reading the type from ghci:
```hs
dingo :: (x, x) -> [x]
```
the reason why y disappears is because for dingo to return a list with both x and y, x and y has to have the same type. something to note here is that we're talking types of variables called x and y, not variables in themselves - and as such we can omit some of these names.

i think it is overloading, because the function takes a tuple, so if tuples are types in the same way it would be overloading

ex 4:

it should be `Ord a => [a] -> Int`

ex 5:

skipped...

ex a:

```hs
mango :: Num a => a -> a -> a -> a
```

ex b:

```hs
bingo :: a -> a
bingo a = a
```

ex c:

```hs
thesame :: Eq a => [a] -> [(a, a)]
```

ex d:

the expression contains functions, as everything is a function in haskell, then i would assume the type to be [a]

the correct type is `Num [a] => [[a] -> [a] -> [a]]`

ex e:

```hs
map :: (a -> b) -> [a] -> [b]
```
because (a -> b) shows a function declaration, it is denoted by the parenthesis and the arrow operator.

ex f:

```hs
expr :: (Ord a1, Eq a2) => a2 -> a2 -> (a1, a1) -> a1

expr eq1 eq2 (ord1, ord2) = if y then if ord1 < ord2 then ord1 else ord2 else if ord2 < ord1 then ord1 else ord2 
    where y = eq1 == eq2
```

ex g:
```hs

```