module Fs0903

open System

let g (x:double):double =
    (x / 2.0) + (1.0 / x)

let rec iterative (x0:double):double =
    let x1 = g(x0)
    printfn "%12.10f\t%13.10f" x1 (x1 - Math.Sqrt(2.0))

    if abs(x1 - x0) < 0.0000000001 then
        x1
    else
        iterative x1

let x = 1.0
printfn "%12.10f" (iterative x)

exit 0
