-- ex1

--triples :: Num a => [(a,a,a)] -> ([a], [a], [a])
--triples [] = ()
--triples [(a,b,c)] = ([a], [b], [c])
--triples (x:xs, y:ys, z:zs) = [x,y,z] : triples [(xs,ys,zs)]

--aight there's quite a few problems, first off the type class "Num" could be more generic, i'd say this function doesn't need a type class at all
triples :: [(a,a,a)] -> ([a], [a], [a])

--next up, the pattern [] is wrong, its return type is () while it should  be ([a], [a], [a]). i think this one can be omitted
triples [] = ([], [], [])

--the third line should maybe also be removed
--triples [(a,b,c)] = ([a], [b], [c])

--the last line should be changed, it is completely wrong, having wrong types everywhere
triples ((x,y,z):ts) = (xs, ys, zs)
    where
        xs = x : [x | (x,_,_) <- ts]
        ys = y : [y | (_,y,_) <- ts]
        zs = z : [z | (_,_,z) <- ts]

-- ex2
--cfrac r n = [x | x <- [0..r]]
-- do later

-- ex3
alone xs = [e | e <- xs, (length [e2 | e2 <- xs, e2 == e]) == 1]
-- is alone polymorphic?
-- do later

-- ex4
myMap p xs = [foldr p 1 [x] | x <- xs]

-- ex5
ex5a :: (Ord a, Num a) => a -> a -> [[Bool]] -> Bool
ex5a a1 a2 l = if a1 < a2 then (head l) else (tail l)
ex5a a1 a2 [l] = head l
ex5a a1 a2 [] = False