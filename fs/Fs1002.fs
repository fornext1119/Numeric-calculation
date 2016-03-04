module Fs1002

open System

let N = 3 

// １次元配列を表示
let disp_vector (row:float[]) =
    row
    |> Array.iter (fun x -> printf "%14.10f" x)
    printfn ""

// ガウス・ザイデル法
let gauss (a:float[][]) (b:float[]) (x0:float[]) =
    let mutable finish:bool = false
    while not finish do
        finish <- true

        for i in [0..N] do
            let mutable x1:float = 0.0
            for j in [0..N] do
               if j <> i then
                   x1 <- x1 + a.[i].[j] * x0.[j]

            x1 <- (b.[i] - x1) / a.[i].[i]
            if Math.Abs(x1 - x0.[i]) > 0.0000000001 then
                finish <- false

            x0.[i] <- x1

        if not finish then 
            disp_vector x0

let a:float[][] = [| [| 9.0;2.0;1.0;1.0 |]; [|2.0;8.0;-2.0;1.0 |]; [|-1.0;-2.0;7.0;-2.0 |]; [|1.0;-1.0;-2.0;6.0 |] |]
let b:float[] = [| 20.0;16.0;8.0;17.0 |]
let c:float[] = [| 0.0;0.0;0.0;0.0 |]

// ガウス・ザイデル法
gauss a b c

printfn "X"
disp_vector c

exit 0
