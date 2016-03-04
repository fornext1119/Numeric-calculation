foldl (+) 0 $ filter (\x -> mod x 3 == 0) [1..99]
sum $ filter (\x -> mod x 3 == 0) [1..99]
