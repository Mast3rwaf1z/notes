-- ex a
qsort :: (Ord a) => [a] -> [a]

qsort [] = []
qsort (x:xs) = small ++ [x] ++ big
                 where small = qsort [a | a <- xs, a < x]
                       big   = qsort [a | a <- xs, a > x]

myQsort [] = []
myQsort (x:xs) = big ++ [x] ++ small
    where   small   = myQsort [a | a <- xs, a <= x]
            big     = myQsort [a | a <- xs, a > x]

-- part 2: yes, because the strings are still ordered, as a list of strings is essentially a list of lists of chars, while a list of lists of chars is essentially also just a list of lists of integers

-- ex b
-- some elements would be discarded, namely elements which are equal to x.