-- 自作の対数関数
myLog::Double->Double->Double->Double->Double;
myLog x2 numerator denominator y =
let
    denom = denominator + 2.0
    num   = numerator   * x2 * x2
    a     = num / denom
in 
    -- 十分な精度になったら処理を抜ける
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (myLog x2 num denom a)
import Text.Printf
import Control.Monad

forM_ (
    map (\n -> (fromIntegral n) / 5.0) $ 
    [1..20::Int]
) $ \x -> do
    -- 標準の対数関数
    let d1 = log(x)
    -- 自作の対数関数
    let x2 = (x - 1.0) / (x + 1.0)
    let d2 = 2.0 * (myLog x2 x2 1.0 x2)
    -- 標準関数との差異
    printf "%5.2f : %13.10f - %13.10f = %13.10f\n" x d1 d2 (d1- d2)
