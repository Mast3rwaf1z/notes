-- lecture exercises
-- ex 1
allButSecond :: [a] -> [a]
allButSecond l = [head l] ++ (drop 2 l)

-- ex 2
midtover :: [a] -> ([a], [a])
midtover l = (take (div (length l) 2) l, drop (div (length l) 2) l)

-- ex 3
-- indentation
-- placement of mod or missing backticks

bingo :: Integral a => a -> a -> a
bingo x y = mod x z
    where z = y + 42

-- ex a
final l = head (reverse l)

