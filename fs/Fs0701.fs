module Fs0701

open System

// データ点の数 - 1
let N = 6 

// 元の関数
let f (x:double):double =
    x - Math.Pow(x,3.0) / (float (3 * 2)) + Math.Pow(x,5.0) / (float (5 * 4 * 3 * 2))

// Lagrange (ラグランジュ) 補間
let lagrange(d:double) (x:double list) (y:double list) =
    let mutable sum_list = [0.0]
    for i in [0..N] do
        let mutable prod_list = [y.[i]]
        for j in [0..N] do
            if i <> j then
                prod_list <- ((d - x.[j]) / (x.[i] - x.[j]))::prod_list
        sum_list <- (prod_list |> List.reduce(*))::sum_list
    sum_list |> List.sum

// 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
let x = [0..N] |> List.map(fun i -> (float i) * 1.5 - 4.5)
let y = x |> List.map(f)

// 0.5刻みで 与えられていない値を補間
let d1 = [0..18] |> List.map(fun i -> (float i) * 0.5 - 4.5)
let d2 = d1 |> List.map(f)
let d3 = d1 |> List.map(fun d -> (lagrange d x y))

(List.zip (List.zip d1 d2) d3)
|> List.iter (fun ((d1, d2), d3) -> printfn "%5.2f\t%8.5f\t%8.5f\t%8.5f" d1 d2 d3 (d2 - d3))

exit 0
