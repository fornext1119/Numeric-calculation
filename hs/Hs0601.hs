import Text.Printf
import Control.Monad

f::Double->Double
f x = 4 / (1 + (x * x))

main = do 
    forM_ ([1..10::Integer]) $ \j -> do
        let n = 2 ^ j 
        let a = 0.0
        let b = 1.0
        let h = (b - a) / (fromIntegral n)
        -- ‘äŒ`‘¥‚ÅÏ•ª
        let w1 = sum $ map(\x -> f x) $ map(\i -> (fromIntegral i) * h + a) $ [1..(n - 1)]
        let w2 = ((f a) + (f b)) / 2
        let t1 = h * (w1 + w2)
        -- Œ‹‰Ê‚ð ƒÎ ‚Æ”äŠr
        let t2 = t1 - pi
        printf "%3d : %13.10f, %13.10f\n" j t1 t2
