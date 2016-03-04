-- 自作の指数関数
myExp::Double->Int->Double->Double->Double->Double
myExp x n numerator denominator y =
let
    denom = denominator * (fromIntegral n)
    num   = numerator   * x
    a     = num / denom
in 
    -- 十分な精度になったら処理を抜ける
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (myExp x (n + 1) num denom a)
import Text.Printf
import Control.Monad

forM_ (
    map (\n -> (fromIntegral (n - 10)) / 4.0) $ 
    [0..20::Int]
) $ \x -> do
    -- 標準の指数関数
    let d1 = exp(x)
    -- 自作の指数関数
    let d2 = (myExp x 1 1.0 1.0 1.0)
    -- 標準関数との差異
    printf "%5.2f : %13.10f - %13.10f = %13.10f\n" x d1 d2 (d1- d2)
