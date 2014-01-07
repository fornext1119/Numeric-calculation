module Fs0601

open System

let f(x:double):double =
    4.0 / (1.0 + x * x)

let a:double = 0.0
let b:double = 1.0

// ��`���Őϕ�
let mutable n = 2
for j in [1..10] do
    let         h:double = (b - a) / (double n)
    let mutable s:double = 0.0
    let mutable x:double = a

    for i in [1..(n - 1)] do
        x <- x + h
        s <- s + (f x)
    s <- h * (((f a) + (f b)) / 2.0 + s)
    n <- n * 2

    // ���ʂ� �� �Ɣ�r
    printfn "%3d : %13.10f, %13.10f" j s (s - Math.PI)

exit 0
