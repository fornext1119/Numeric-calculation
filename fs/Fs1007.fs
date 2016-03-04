module Fs1007

open System

let N = 3 

// １次元配列を表示
let disp_vector (row:float[]) =
    row
    |> Array.iter (fun x -> printf "%14.10f" x)
    printfn ""

// ２次元配列を表示
let disp_matrix (matrix:float[][]) =
    matrix
    |> Array.iter 
        (fun row -> 
            row
            |> Array.iter (fun col -> printf "%14.10f" col)
            printfn ""
        )

// 前進消去
let forward_elimination (a:float[][]) (b:float[]) =
    for pivot in [0..N] do
        let mutable s:float = 0.0

        // pivot < k の場合
        for col in 0..(pivot - 1) do
            s <- a.[pivot].[col]
            for k in 0..(col - 1) do
                s <- s - a.[pivot].[k] * a.[col].[k] * a.[k].[k]
            a.[pivot].[col] <- s / a.[col].[col]
            a.[col].[pivot] <- a.[pivot].[col]
 
        // pivot == k の場合
        s <- a.[pivot].[pivot]
        for k in 0..(pivot - 1) do
            s <- s - a.[pivot].[k] * a.[pivot].[k] * a.[k].[k]
        a.[pivot].[pivot] <- s

// 前進代入
let forward_substitution (a:float[][]) (b:float[]) (y:float[]) =
    for row in [0..N] do
        for col in 0..(row - 1) do
            b.[row] <- b.[row] - a.[row].[col] * y.[col]
        y.[row] <- b.[row]

// 後退代入
let backward_substitution (a:float[][]) (y:float[]) (x:float[]) =
    for row in (List.rev [0..N]) do
        for col in (List.rev [row + 1 .. N]) do
            y.[row] <- y.[row] - a.[row].[col] * a.[row].[row] * x.[col]
        x.[row] <- y.[row] / a.[row].[row]

let mutable a:float[][] = [| [|5.0;2.0;3.0;4.0 |]; [|2.0;10.0;6.0;7.0 |]; [| 3.0;6.0;15.0;9.0 |]; [|4.0;7.0;9.0;20.0 |] |]
let mutable b:float[] = [| 34.0;68.0;96.0;125.0 |]

printfn "A"
disp_matrix a
printfn "B"
disp_vector b
printfn ""

// 前進消去
forward_elimination a b

printfn "LDL^T"
disp_matrix a

// Ly=b から y を求める (前進代入)
let mutable y:float[] = [| 0.0;0.0;0.0;0.0 |]
forward_substitution a b y

printfn "Y"
disp_vector y

// DL^Tx=y から x を求める (後退代入)
let mutable x:float[] = [| 0.0;0.0;0.0;0.0 |]
backward_substitution a y x

printfn "X"
disp_vector x

exit 0
