import Text.Printf

main = do
    print (3 + 5)
    print (3 - 5)
    print (3 * 5)
    print (3 ^ 5)
    print (5 / 3)
    print (5 `div` 3)

    print (div  5 3)
    print (mod  5 3)
    print (quot 5 3)
    print (rem  5 3)

    print (div  (-5) 3)
    print (mod  (-5) 3)
    print (quot (-5) 3)
    print (rem  (-5) 3)

    putStrLn ((show (3 * 5)))

    printf "%3d\n"  ((3 * 5)::Int)
    printf "%23.20f\n" ((5 / 3)::Double)
