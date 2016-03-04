module Fs0702

open System

// データ点の数 - 1
let N = 6 

// 元の関数
let f (x:double):double =
    x - Math.Pow(x,3.0) / (float (3 * 2)) + Math.Pow(x,5.0) / (float (5 * 4 * 3 * 2))

// Neville (ネヴィル) 補間
let neville(d:double) (x:double list) (y:double list) =
    let w = Array2D.zeroCreate<double> (N+1) (N+1)
    for i in [0..N] do
        w.[0,i] <- y.[i]
    for j in [1..N] do
        for i in [0..N-j] do
              w.[j,i] <- w.[j-1,i+1] + (w.[j-1,i+1] - w.[j-1,i]) * (d - x.[i+j]) / (x.[i+j] - x.[i])
    w.[N,0]

// 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
let x = [0..N] |> List.map(fun i -> (float i) * 1.5 - 4.5)
let y = x |> List.map(f)

// 0.5刻みで 与えられていない値を補間
let d1 = [0..18] |> List.map(fun i -> (float i) * 0.5 - 4.5)
let d2 = d1 |> List.map(f)
let d3 = d1 |> List.map(fun d -> (neville d x y))

(List.zip (List.zip d1 d2) d3)
|> List.iter (fun ((d1, d2), d3) -> printfn "%5.2f\t%8.5f\t%8.5f\t%8.5f" d1 d2 d3 (d2 - d3))

exit 0
