import Text.Printf 

main = do
    let i = (3 * 5)::Int
    printf "3 * 5 = %d\n" i
    putStrLn ("3 * 5 = " ++ (show i))
