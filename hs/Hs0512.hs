-- 自作の逆正接関数
myAtan::Double->Double->Int->Double->Double
myAtan x x2 n t =
let
    m     = (fromIntegral (n `div` 2))
    denom = (m * m * x2) / ((fromIntegral n) + t)
    num   = n - 2
in 
    if num <= 1 then
        x / (1.0 + denom)
    else
        myAtan x x2 num denom

import Text.Printf
import Control.Monad

:{
forM_ (
    map (\n -> n * 2 + 1) $ 
    [5..15::Int]
) $ \i -> do -- 11..31
    let radian = 1
    -- 自作の逆正接関数
    let x2 = radian * radian
    let d1 = (myAtan radian x2 i 0.0) -- i:必要な精度が得られる十分大きな奇数
    -- 標準の逆正接関数
    let d2 = atan(radian)
    -- 標準関数との差異
    printf "%2d : %13.10f, %13.10f\n" i (d1 * 4) (d1 * 4 - pi)
:}


printf "%33.30f\n" pi
 3.14159 26535 89793 
 3.14159 26535 89793 23846 26433 83279 50288 …

