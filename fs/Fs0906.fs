module Fs0906

open System

let f (x:double):double =
    x * x - 2.0

let rec secant (x0:double)(x1:double):double =
    let x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
    printfn "%12.10f\t%13.10f" x2 (x2 - Math.Sqrt(2.0))

    if abs(x2 - x1) < 0.0000000001 then
        x2
    else
        secant x1 x2

let x0 = 1.0
let x1 = 2.0
printfn "%12.10f" (secant x0 x1)

exit 0
