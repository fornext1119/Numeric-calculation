module Fs1003

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
    for pivot in [0..N - 1] do
        for row in [pivot + 1 .. N] do
            let s:float = a.[row].[pivot] / a.[pivot].[pivot]
            for col in [pivot..N] do
                a.[row].[col] <- a.[row].[col] - a.[pivot].[col]    * s
            b.[row]           <- b.[row]       - b.[pivot]          * s

// ��ޑ��
let backward_substitution (a:float[][]) (b:float[]) =
    for row in (List.rev [0..N]) do
        for col in (List.rev [row + 1 .. N]) do
            b.[row] <- b.[row] - a.[row].[col] * b.[col]
        b.[row] <- b.[row] / a.[row].[row]

// �s�{�b�g�I��
let pivoting (a:float[][]) (b:float[]) =
    for pivot in [0..N] do
        // �e��� ��Ԓl���傫���s�� �T��
        let mutable max_row:int = pivot
        let mutable max_val:float = 0.0
        for row in [pivot..N] do
            if (Math.Abs(a.[row].[pivot]) > max_val) then
                // ��Ԓl���傫���s
                max_val <- Math.Abs(a.[row].[pivot])
                max_row <- row

        // ��Ԓl���傫���s�Ɠ���ւ�
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

// �s�{�b�g�I��
pivoting a b

printfn "pivoting"
printfn "A"
disp_matrix a
printfn "B"
disp_vector b
printfn ""

// �O�i����
forward_elimination a b

printfn "forward elimination"
printfn "A"
disp_matrix a
printfn "B"
disp_vector b
printfn ""

// ��ޑ��
backward_substitution a b

printfn "X"
disp_vector b

exit 0
