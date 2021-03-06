module Fs0902

open System

let f (x:double):double =
    x * x - 2.0

let rec falseposition (a:double) (b:double):double =
    // 点 (a,f(a)) と 点 (b,f(b)) を結ぶ直線と x軸の交点
    let c = (a * f(b) - b * f(a)) / (f(b) - f(a))
    printfn "%12.10f\t%13.10f" c (c - Math.Sqrt(2.0))

    let fc = f c
    if abs(fc) < 0.0000000001 then
        c
    else
        if fc < 0.0 then
            // f(c) < 0 であれば, 解は区間 (c, b) の中に存在
            falseposition c b
        else
            // f(c) > 0 であれば, 解は区間 (a, c) の中に存在
            falseposition a c

let a = 1.0
let b = 2.0
printfn "%12.10f" (falseposition a b)

exit 0
