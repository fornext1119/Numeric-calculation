module Fs1001

open System

let N = 3 

// １次元配列を表示
let disp_vector (row:float[]) =
    row
    |> Array.iter (fun x -> printf "%14.10f" x)
    printfn ""

// ヤコビの反復法
let jacobi (a:float[][]) (b:float[]) (x0:float[]) =
    let mutable finish:bool = false
    while not finish do
        let x1:float[] = [| 0.0;0.0;0.0;0.0 |]
        finish <- true

        for i in [0..N] do
            x1.[i] <- 0.0
            for j in [0..N] do
               if j <> i then
                   x1.[i] <- x1.[i] + a.[i].[j] * x0.[j]

            x1.[i] <- (b.[i] - x1.[i]) / a.[i].[i]
            if Math.Abs(x1.[i] - x0.[i]) > 0.0000000001 then
                finish <- false

        for i in [0..N] do
            x0.[i] <- x1.[i]

        if not finish then 
            disp_vector x0

let a:float[][] = [| [| 9.0;2.0;1.0;1.0 |]; [|2.0;8.0;-2.0;1.0 |]; [|-1.0;-2.0;7.0;-2.0 |]; [|1.0;-1.0;-2.0;6.0 |] |]
let b:float[] = [| 20.0;16.0;8.0;17.0 |]
let c:float[] = [| 0.0;0.0;0.0;0.0 |]

// ヤコビの反復法
jacobi a b c

printfn "X"
disp_vector c

exit 0
