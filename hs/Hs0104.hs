import Text.Printf 
import Control.Monad

main = do
    forM [1..9::Int] $ \i -> do
        if (i `mod` 3 == 0) 
            then printf "%d, " i
            else printf ""
