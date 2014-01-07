module Fs0603

open System

let f(x:double):double =
    4.0 / (1.0 + x * x)

let a:double = 0.0
let b:double = 1.0

// Simpsonë•Ç≈êœï™
let mutable n = 2
for j in [1..5] do
    let         h:double  = (b - a) / (double n)
    let mutable s2:double = 0.0
    let mutable s4:double = 0.0
    let mutable x:double  = a + h

    for i in [1..(n / 2)] do
        s4 <- s4 + (f x)
        x  <- x  + h
        s2 <- s2 + (f x)
        x  <- x  + h
    s2 <- (s2 - (f b)) * 2.0 + (f a) + (f b)
    s4 <- s4 * 4.0
    let s = (s2 + s4) * h / 3.0
    n <- n * 2

    // åãâ Ç ÉŒ Ç∆î‰är
    printfn "%3d : %13.10f, %13.10f" j s (s - System.Math.PI)

exit 0
