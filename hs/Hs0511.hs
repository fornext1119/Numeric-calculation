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

forM_ (
    map (\n -> n - 45) $ 
    map (* 15) $ 
    [0..6::Int]
) $ \degree -> do
    let radian = (fromIntegral degree) * pi / 180.0
    -- 自作の逆正接関数
    let x2 = radian * radian
    let d1 = (myAtan radian x2 23 0.0) -- 23:必要な精度が得られる十分大きな奇数
    -- 標準の逆正接関数
    let d2 = atan(radian)
    -- 標準関数との差異
    printf "%3d : %13.10f - %13.10f = %13.10f\n" degree d1 d2 (d1- d2)
