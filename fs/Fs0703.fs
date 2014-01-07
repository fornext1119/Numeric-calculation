module Fs0703

open System

// データ点の数 - 1
let N = 6 

// 元の関数
let f (x:double):double =
    x - Math.Pow(x,3.0) / (float (3 * 2)) + Math.Pow(x,5.0) / (float (5 * 4 * 3 * 2))

// Newton (ニュートン) 補間
let newton(d:double) (x:double list) (a:double list) =
    let mutable sum_list = [a.[0]]
    for i in [1..N] do
        let mutable prod_list = [a.[i]]
        for j in [0..i-1] do
            prod_list <- (d - x.[j])::prod_list
        sum_list <- (prod_list |> List.reduce(*))::sum_list
    sum_list |> List.sum

// 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
let x = [0..N] |> List.map(fun i -> (float i) * 1.5 - 4.5)
let y = x |> List.map(f)

// 差分商の表を作る
let d = Array2D.zeroCreate<double> (N+1) (N+1)
for j in [0..N] do
    d.[0,j] <- y.[j]

for i in [1..N] do
    for j in [0..N-i] do
        d.[i,j] <- (d.[i-1,j+1] - d.[i-1,j]) / (x.[j+i] - x.[j])

// ｎ階差分商
let a = [0..N] |> List.map(fun i -> d.[i,0])

// 0.5刻みで 与えられていない値を補間
let d1 = [0..18] |> List.map(fun i -> (float i) * 0.5 - 4.5)
let d2 = d1 |> List.map(f)
let d3 = d1 |> List.map(fun d -> (newton d x a))

(List.zip (List.zip d1 d2) d3)
|> List.iter (fun ((d1, d2), d3) -> printfn "%5.2f\t%8.5f\t%8.5f\t%8.5f" d1 d2 d3 (d2 - d3))

exit 0
