-- 自作の双曲線正弦関数
mySinh::Double->Int->Double->Double->Double->Double
mySinh x n numerator denominator y =
let
    m     = 2 * n
    denom = denominator * (fromIntegral (m + 1)) * (fromIntegral m)
    num   = numerator   * x * x
    a     = num / denom
in 
    -- 十分な精度になったら処理を抜ける
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (mySinh x (n + 1) num denom a)
import Text.Printf
import Control.Monad

forM_ (
    map ((-) 10) $ 
    [0..20::Int]
) $ \i -> do
    -- 自作の双曲線正弦関数
    let x  = (fromIntegral i)
    let d1 = (mySinh x 1 x 1.0 x)
    -- 標準の双曲線正弦関数
    let d2 = sinh(x)
    -- 標準関数との差異
    printf "%3d : %17.10f - %17.10f = %13.10f\n" i d1 d2 (d1- d2)
