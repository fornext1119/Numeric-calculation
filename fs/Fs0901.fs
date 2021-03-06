module Fs0901

open System

let f (x:double):double =
    x * x - 2.0

let rec bisection (a:double) (b:double):double =
    // 区間 (a, b) の中点 c = (a + b) / 2
    let c = (a + b) / 2.0
    printfn "%12.10f\t%13.10f" c (c - Math.Sqrt(2.0))

    let fc = f c
    if abs(fc) < 0.0000000001 then
        c
    else
        if fc < 0.0 then
            // f(c) < 0 であれば, 解は区間 (c, b) の中に存在
            bisection c b
        else
            // f(c) > 0 であれば, 解は区間 (a, c) の中に存在
            bisection a c

let a = 1.0
let b = 2.0
printfn "%12.10f" (bisection a b)

exit 0
