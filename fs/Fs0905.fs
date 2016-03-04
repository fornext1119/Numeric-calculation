module Fs0905

open System

let f0 (x:double):double =
    x * x - 2.0

let f1 (x:double):double =
    2.0 * x

let f2 (x:double):double =
    2.0

let rec bailey (x0:double):double =
    let x1 = x0 - (f0(x0) / (f1(x0) - (f0(x0) * f2(x0) / (2.0 * f1(x0)))))
    printfn "%12.10f\t%13.10f" x1 (x1 - Math.Sqrt(2.0))

    if abs(x1 - x0) < 0.0000000001 then
        x1
    else
        bailey x1

let x = 2.0
printfn "%12.10f" (bailey x)

exit 0
