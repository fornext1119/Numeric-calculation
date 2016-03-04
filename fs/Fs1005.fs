module Fs1005

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
                a.[row].[col] <- a.[row].[col] - a.[pivot].[col]    * s // ���ꂪ ��O�p�s��
            a.[row].[pivot]   <- s                                      // ���ꂪ ���O�p�s��
            // b.[row]        <- b.[row]       - b.[pivot]          * s // ���̒l�͕ύX���Ȃ�

// �O�i���
let forward_substitution (a:float[][]) (b:float[]) (y:float[]) =
    for row in [0..N] do
        for col in 0..(row - 1) do
            b.[row] <- b.[row] - a.[row].[col] * y.[col]
        y.[row] <- b.[row]

// ��ޑ��
let backward_substitution (a:float[][]) (y:float[]) (x:float[]) =
    for row in (List.rev [0..N]) do
        for col in (List.rev [row + 1 .. N]) do
            y.[row] <- y.[row] - a.[row].[col] * x.[col]
        x.[row] <- y.[row] / a.[row].[row]

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

printfn "LU"
disp_matrix a

// Ly=b ���� y �����߂� (�O�i���)
let mutable y:float[] = [| 0.0;0.0;0.0;0.0 |]
forward_substitution a b y

printfn "Y"
disp_vector y

// Ux=y ���� x �����߂� (��ޑ��)
let mutable x:float[] = [| 0.0;0.0;0.0;0.0 |]
backward_substitution a y x

printfn "X"
disp_vector x

exit 0
