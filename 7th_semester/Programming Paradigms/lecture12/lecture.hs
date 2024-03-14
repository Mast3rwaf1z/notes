
-- exercise 1

import Parsing

term = int

expr :: Parser Int
expr = do
    t <- term
    return t
    <|>
    do
        t <- term
        symbol  "+"
        e <- expr
        return (t + e)

-- exercise 2

