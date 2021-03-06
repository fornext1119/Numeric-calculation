import Text.Printf
import Debug.Trace

f::Double->Double
f x = x * x - 2.0

falseposition::Double->Double->Double
falseposition a b =
    let
        -- 点 (a,f(a)) と 点 (b,f(b)) を結ぶ直線と x軸の交点
        c = (a * (f b) - b * (f a)) / ((f b) - (f a))
        fc = (f c) :: Double
    in
        if abs(fc) < 0.0000000001 then
            c
        else
            trace (printf "%12.10f\t%13.10f" c (c - ((sqrt 2.0)::Double))) $
            if fc < 0.0
                then
                    -- f(c) < 0 であれば, 解は区間 (c, b) の中に存在
                    falseposition c b
                else
                    -- f(c) > 0 であれば, 解は区間 (a, c) の中に存在
                    falseposition a c

main = do
    let a = 1.0
    let b = 2.0
    printf "%12.10f\n" (falseposition a b)
