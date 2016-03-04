module Fs0604

open System

let f(x:double):double =
    4.0 / (1.0 + x * x)

let a:double = 0.0
let b:double = 1.0

let t = Array2D.zeroCreate<double> 7 7

// ë‰å`ë•Ç≈êœï™
let mutable n = 2
for i in [1..6] do
    let         h:double = (b - a) / (double n)
    let mutable s:double = 0.0
    let mutable x:double = a

    for j in [1..(n - 1)] do
        x <- x + h
        s <- s + (f x)

    // åãâ Çï€ë∂
    t.[i,1] <- h * (((f a) + (f b)) / 2.0 + s)
    n <- n * 2

// RichardsonÇÃï‚äOñ@
n <- 4
for j in [2..6] do
    for i in [j..6] do
        t.[i,j] <- t.[i, j - 1] + (t.[i, j - 1] - t.[i - 1, j - 1]) / (double (n - 1))
        if i = j then
            // åãâ Ç ÉŒ Ç∆î‰är
            printfn "%3d : %13.10f, %13.10f" j t.[i,j] (t.[i,j] - Math.PI)
    n <- n * 4

exit 0
