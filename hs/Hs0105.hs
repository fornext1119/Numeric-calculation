total 0 = 0
total i =
    if i `mod` 3 == 0 then
        i + total (i - 1)
    else
        total (i - 1)
        
main = print (total 99)
