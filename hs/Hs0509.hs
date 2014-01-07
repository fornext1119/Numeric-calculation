-- 自作の双曲線余弦関数
myCosh::Double->Int->Double->Double->Double->Double;
myCosh x n numerator denominator y =
let
    m     = 2 * n
    denom = denominator * (fromIntegral m) * (fromIntegral (m - 1))
    num   = numerator   * x * x
    a     = num / denom
in 
    -- 十分な精度になったら処理を抜ける
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (myCosh x (n + 1) num denom a)
import Text.Printf
import Control.Monad

forM_ (
    map ((-) 10) $ 
    [0..20::Int]
) $ \i -> do
    -- 自作の双曲線余弦関数
    let x  = (fromIntegral i)
    let d1 = (myCosh x 1 1.0 1.0 1.0)
    -- 標準の双曲線余弦関数
    let d2 = cosh(x)
    -- 標準関数との差異
    printf "%3d : %17.10f - %17.10f = %13.10f\n" i d1 d2 (d1- d2)
