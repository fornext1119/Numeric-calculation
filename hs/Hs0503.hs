-- 自作の正接関数
myTan::Double->Double->Int->Double->Double
myTan x x2 n t =
let
    denom = x2 / ((fromIntegral n) - t)
    num   = n - 2
in 
    if num <= 1 then
        x / (1.0 - denom)
    else
        myTan x x2 num denom
import Text.Printf
import Control.Monad

forM_ (
    map    (\n -> n - 90) $ 
    filter (\n -> mod n 180 /= 0) $ 
    map    (* 15) $ 
    [0..12::Int]
) $ \degree -> do
    let radian = (fromIntegral degree) * pi / 180.0
    -- 自作の正接関数
    let x2 = radian * radian
    let d1 = (myTan radian x2 15 0.0) -- 15:必要な精度が得られる十分大きな奇数
    -- 標準の正接関数
    let d2 = tan(radian)
    -- 標準関数との差異
    printf "%3d : %13.10f - %13.10f = %13.10f\n" degree d1 d2 (d1- d2)
