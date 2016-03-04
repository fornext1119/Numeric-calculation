module Fs1006

open System

let N = 3 

// �P�����z���\��
let disp_vector (row:float[]) =
    row
    |> Array.iter (fun x -> printf "%14.10f" x)
    printfn ""

// �Q�����z���\��
let disp_matrix (matrix:float[][]) =
    matrix
    |> Array.iter 
        (fun row -> 
            row
            |> Array.iter (fun col -> printf "%14.10f" col)
            printfn ""
        )

// �O�i����
let forward_elimination (a:float[][]) (b:float[]) =
    for pivot in [0..N] do
        let mutable s:float = 0.0
        for col in [0..(pivot - 1)] do
            s <- s + a.[pivot].[col] * a.[pivot].[col]
        // �����ō����̒������̒l�ɂȂ�ƌv�Z�ł��Ȃ��I
        a.[pivot].[pivot] <- Math.Sqrt(a.[pivot].[pivot] - s)


        for row in [pivot + 1 .. N] do
            s <- 0.0
            for col in [0..(pivot-1)] do
                s <- s + a.[row].[col] * a.[pivot].[col]
            a.[row].[pivot] <- (a.[row].[pivot] - s) / a.[pivot].[pivot]
            a.[pivot].[row] <- a.[row].[pivot]

// �O�i���
let forward_substitution (a:float[][]) (b:float[]) (y:float[]) =
    for row in [0..N] do
        for col in 0..(row - 1) do
            b.[row] <- b.[row] - a.[row].[col] * y.[col]
        y.[row] <- b.[row] / a.[row].[row]

// ��ޑ��
let backward_substitution (a:float[][]) (y:float[]) (x:float[]) =
    for row in (List.rev [0..N]) do
        for col in (List.rev [row + 1 .. N]) do
            y.[row] <- y.[row] - a.[row].[col] * x.[col]
        x.[row] <- y.[row] / a.[row].[row]

let mutable a:float[][] = [| [|5.0;2.0;3.0;4.0 |]; [|2.0;10.0;6.0;7.0 |]; [| 3.0;6.0;15.0;9.0 |]; [|4.0;7.0;9.0;20.0 |] |]
let mutable b:float[] = [| 34.0;68.0;96.0;125.0 |]

printfn "A"
disp_matrix a
printfn "B"
disp_vector b
printfn ""

// �O�i����
forward_elimination a b

printfn "LL^T"
disp_matrix a

// Ly=b ���� y �����߂� (�O�i���)
let mutable y:float[] = [| 0.0;0.0;0.0;0.0 |]
forward_substitution a b y

printfn "Y"
disp_vector y

// L^Tx=y ���� x �����߂� (��ޑ��)
let mutable x:float[] = [| 0.0;0.0;0.0;0.0 |]
backward_substitution a y x

printfn "X"
disp_vector x

exit 0
