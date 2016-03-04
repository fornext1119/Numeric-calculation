import Text.Printf
import Control.Monad

f::Double->Double
f x = 4 / (1 + (x * x))

main = do 
    forM_ ([1..5::Integer]) $ \j -> do
        let n  = 2 ^ j
        let a  = 0.0
        let b  = 1.0
        let h  = (b - a) / (fromIntegral n)
        -- ƒVƒ“ƒvƒ\ƒ“‘¥‚ÅÏ•ª
        let w4 = sum $ map(\x -> (f ((fromIntegral x) * h))) $ map(\i -> i * 2 - 1) $ [1..(div n 2)]
        let w2 = sum $ map(\x -> (f ((fromIntegral x) * h))) $ map(\i -> i * 2)     $ [1..(div n 2)]
        let t1 = (w2 - (f b)) * 2 + (f a) + (f b)
        let t2 = w4 * 4
        let t3 = (t1 + t2) * h / 3
        -- Œ‹‰Ê‚ð ƒÎ ‚Æ”äŠr
        let t4 = t3 - pi
        printf "%3d : %13.10f, %13.10f\n" j t3 t4
