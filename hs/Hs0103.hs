import Text.Printf 
import Control.Monad

main = do
    forM [1..9::Int] $ \i -> printf "%d, " i
