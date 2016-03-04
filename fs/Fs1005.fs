module Fs1005

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
    for pivot in [0..N - 1] do
        for row in [pivot + 1 .. N] do
            let s:float = a.[row].[pivot] / a.[pivot].[pivot]
            for col in [pivot..N] do
                a.[row].[col] <- a.[row].[col] - a.[pivot].[col]    * s // これが 上三角行列
            a.[row].[pivot]   <- s                                      // これが 下三角行列
            // b.[row]        <- b.[row]       - b.[pivot]          * s // この値は変更しない

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
            y.[row] <- y.[row] - a.[row].[col] * x.[col]
        x.[row] <- y.[row] / a.[row].[row]

// ピボット選択
let pivoting (a:float[][]) (b:float[]) =
    for pivot in [0..N] do
        // 各列で 一番値が大きい行を 探す
        let mutable max_row:int = pivot
        let mutable max_val:float = 0.0
        for row in [pivot..N] do
            if (Math.Abs(a.[row].[pivot]) > max_val) then
                // 一番値が大きい行
                max_val <- Math.Abs(a.[row].[pivot])
                max_row <- row

        // 一番値が大きい行と入れ替え
        if (max_row <> pivot) then
            let mutable tmp:float = 0.0
            for col in [0..N] do
                tmp               <-   a.[max_row].[col]
                a.[max_row].[col] <-   a.[pivot].[col]
                a.[pivot].[col]   <-   tmp
            tmp         <-   b.[max_row]
            b.[max_row] <-   b.[pivot]
            b.[pivot]   <-   tmp

let mutable a:float[][] = [| [|-1.0;-2.0;7.0;-2.0 |]; [|1.0;-1.0;-2.0;6.0 |]; [| 9.0;2.0;1.0;1.0 |]; [|2.0;8.0;-2.0;1.0 |] |]
let mutable b:float[] = [| 8.0;17.0;20.0;16.0 |]

// ピボット選択
pivoting a b

printfn "pivoting"
printfn "A"
disp_matrix a
printfn "B"
disp_vector b
printfn ""

// 前進消去
forward_elimination a b

printfn "LU"
disp_matrix a

// Ly=b から y を求める (前進代入)
let mutable y:float[] = [| 0.0;0.0;0.0;0.0 |]
forward_substitution a b y

printfn "Y"
disp_vector y

// Ux=y から x を求める (後退代入)
let mutable x:float[] = [| 0.0;0.0;0.0;0.0 |]
backward_substitution a y x

printfn "X"
disp_vector x

exit 0
