module Fs0704

open System

// データ点の数 - 1
let N   =  6 
let Nx2 = 13 

// 元の関数
let f (x:double):double =
    x - Math.Pow(x,3.0) / (float (3 * 2)) + Math.Pow(x,5.0) / (float (5 * 4 * 3 * 2))
// 導関数
let fd (x:double):double =
    1.0 - Math.Pow(x,2.0) / (float 2) + Math.Pow(x,4.0) / (float (4 * 3 * 2))

// Hermite (エルミート) 補間
let hermite(d:double) (z:double list) (a:double list) =
    let mutable sum_list = [a.[0]]
    for i in [1..Nx2] do
        let mutable prod_list = [a.[i]]
        for j in [0..i-1] do
            prod_list <- (d - z.[j])::prod_list
        sum_list <- (prod_list |> List.reduce(*))::sum_list
    sum_list |> List.sum

// 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
let x  = [0..N] |> List.map(fun i -> (float i) * 1.5 - 4.5)
let y  = x |> List.map(f)
let yd = x |> List.map(fd)

// 差分商の表を作る
let z =  [0..Nx2] |> List.map(fun i -> i / 2) |> List.map(fun j -> x.[j])
let d = Array2D.zeroCreate<double> (Nx2+1) (Nx2+1)
for i in [0..Nx2] do
    d.[0,i] <- y.[i / 2]

for i in [1..Nx2] do
    for j in [0..Nx2-i] do
        if (i = 1 && j % 2 = 0) then
            d.[i,j] <- yd.[j / 2]
        else
            d.[i,j] <- (d.[i-1,j+1] - d.[i-1,j]) / (z.[j+i] - z.[j])

// ｎ階差分商
let a = [0..Nx2] |> List.map(fun i -> d.[i,0])

// 0.5刻みで 与えられていない値を補間
let d1 = [0..18] |> List.map(fun i -> (float i) * 0.5 - 4.5)
let d2 = d1 |> List.map(f)
let d3 = d1 |> List.map(fun d -> (hermite d z a))

(List.zip (List.zip d1 d2) d3)
|> List.iter (fun ((d1, d2), d3) -> printfn "%5.2f\t%8.5f\t%8.5f\t%8.5f" d1 d2 d3 (d2 - d3))

exit 0
