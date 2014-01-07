import Text.Printf
import Control.Monad

f::Double->Double
f x = 4 / (1 + (x * x))

-- Richardsonの補外法
rich_sub n []     ss = ss
rich_sub n (x:[]) ss = ss
rich_sub n (x:xs) ss =
    let
        x2 = (head xs)
        s  = x2 + (x2 - x) / (fromIntegral (n - 1))
    in
        rich_sub n xs (s:ss)

richardson n ([])   = 0
richardson n (x:[]) = x
richardson n (x:xs) =
    let
        s = rich_sub n (x:xs) []
    in
        richardson (n * 4) (reverse s)

main = do 
    let a = 0.0
    let b = 1.0
    t <- forM ([1..6::Integer]) $ \j -> do
        let n = 2 ^ j 
        let h = (b - a) / (fromIntegral n)
        -- 台形則で積分
        let w1 = sum $ map(\x -> f x) $ map(\i -> (fromIntegral i) * h + a) $ [1..(n - 1)]
        let w2 = ((f a) + (f b)) / 2
        let t1 = h * (w1 + w2)
        return t1

    -- Richardsonの補外法で積分して, 結果を π と比較
    forM_ ([2..6::Int]) $ \i -> do
        let s = richardson 4 (take i t)
        printf "%3d : %13.10f, %13.10f\n" i s (s - pi)
