-- exercise 1

lgd [] = 0
lgd (x:xs) = 1 + lgd xs

lgdC :: [a] -> Integer
lgdC [] = 0
lgdC xs = lgdCont (xs, id)
    where
        lgdCont ([], cont) = cont 0
        lgdCont (_:xs, cont) = lgdCont (xs, \r -> cont (r+1))

-- exercise 2
fib :: Integral n => n -> n
fib 0 = 1
fib 1 = 1
fib n = fib (n-1) + fib(n-2)

fibC :: Integral n => n -> n
fibC n = fibCont (n,id)
    where
        fibCont (0, cont) = cont 1
        fibCont (1, cont) = cont 1
        fibCont (n, cont) = fibCont (n-1, \r1 -> fibCont (n-2, \r2 -> cont (r1+r2)))