module Fs0602

open System

let f(x:double):double =
    4.0 / (1.0 + x * x)

let a:double = 0.0
let b:double = 1.0

// ’†“_‘¥‚ÅÏ•ª
let mutable n = 2
for j in [1..10] do
    let         h:double = (b - a) / (double n)
    let mutable s:double = 0.0
    let mutable x:double = a + (h / 2.0)

    for i in [1..n] do
        s <- s + (f x)
        x <- x + h
    s <- s * h
    n <- n * 2

    // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
    printfn "%3d : %13.10f, %13.10f" j s (s - Math.PI)

exit 0
