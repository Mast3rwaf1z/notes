-- #########################
-- pre lecture stuff

improve :: [a] -> [a]

-- this exercise wants us to remove every second element in the list, 
-- the pattern (a:_:as) is a list as an input where the first two elements are removed, the first is stored in a and the second is discarded
-- the second pattern match, matches a single element in the list

-- so the 
improve (a:_:as) = a : improve as
improve a = a

-- ##########################
-- EXERCISE SESSION

-- problem 1
-- define the function rev, that reverses a list
-- i'm just removing the first element and concatenating it at the end of the list
rev :: [a] -> [a]
rev (a:as) = rev as ++ [a]
rev a = a

-- problem 2
myLast :: [a] -> a
myLast (a:b:as) = myLast (b:as)
myLast a = head a

-- problem 3
isolate :: Eq a => [a] -> a -> ([a], [a])
isolate (l:ls) x = if l == x then (l1, l:l2) else (l:l1, l2)
    where
        -- this is what i didn't know: i didn't know i could define the variables l1 and l2 inside the tuple.
        (l1, l2) = isolate ls x
isolate l x = ([], [])

-- problem 4
-- okay so we give the function wrapup a list, and it should return a list of lists containing each successive element in the list.
wrapup :: Eq a => [a] -> [[a]]
wrapup a    | 

-- IMPORTANT: finish when i get home

-- problem a
--rle :: a -> [a] -> [(a, Int)]
--rle (a:as) = rle a as