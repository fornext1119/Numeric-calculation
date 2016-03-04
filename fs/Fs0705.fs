module Fs0705

open System

// データ点の数 - 1
let N = 6 

// 元の関数
let f (x:double):double =
    x - Math.Pow(x,3.0) / (float (3 * 2)) + Math.Pow(x,5.0) / (float (5 * 4 * 3 * 2))

// Spline (スプライン) 補間
let spline(d:double) (x:double list) (y:double list) (z:double list) =
    // 補間関数値がどの区間にあるか
    let mutable k = -1
    for i in [N..(-1)..1] do
        if d <= x.[i] then k <- i - 1
    if k < 0 then k <- N

    let d1 = x.[k+1] - d
    let d2 = d       - x.[k]
    let d3 = x.[k+1] - x.[k]
    (z.[k] * Math.Pow(d1,3.0) + z.[k+1] * Math.Pow(d2,3.0)) / (6.0 * d3) +
    (y.[k]   / d3 - z.[k]   * d3 / 6.0) * d1 +
    (y.[k+1] / d3 - z.[k+1] * d3 / 6.0) * d2

// 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
let x = [0..N] |> List.map(fun i -> (float i) * 1.5 - 4.5)
let y = x |> List.map(f)

// ３項方程式の係数の表を作る
let a = Array.zeroCreate<double> N
let b = Array.zeroCreate<double> N
let c = Array.zeroCreate<double> N
let d = Array.zeroCreate<double> N
for i in [1..N - 1] do
    a.[i] <-         x.[i]   - x.[i-1] 
    b.[i] <- 2.0 *  (x.[i+1] - x.[i-1]) 
    c.[i] <-         x.[i+1] - x.[i] 
    d.[i] <- 6.0 * ((y.[i+1] - y.[i]) / (x.[i+1] - x.[i]) - (y.[i] - y.[i-1]) / (x.[i] - x.[i-1]))
// ３項方程式を解く (ト－マス法)
let g = Array.zeroCreate<double> N
let s = Array.zeroCreate<double> N
g.[1] <- b.[1]
s.[1] <- d.[1]
for i in [2..N - 1] do
    g.[i] <- b.[i] - a.[i] * c.[i-1] / g.[i-1]
    s.[i] <- d.[i] - a.[i] * s.[i-1] / g.[i-1]
let z = Array.zeroCreate<double> (N+1)
z.[0]   <- 0.0
z.[N]   <- 0.0
z.[N-1] <- s.[N-1] / g.[N-1]
for i in [(N-2)..(-1)..1] do
    z.[i] <- (s.[i] - c.[i] * z.[i+1]) / g.[i]

// 0.5刻みで 与えられていない値を補間
let d1 = [0..18] |> List.map(fun i -> (float i) * 0.5 - 4.5)
let d2 = d1 |> List.map(f)
let d3 = d1 |> List.map(fun d -> (spline d x y (Array.toList(z))))

(List.zip (List.zip d1 d2) d3)
|> List.iter (fun ((d1, d2), d3) -> printfn "%5.2f\t%8.5f\t%8.5f\t%8.5f" d1 d2 d3 (d2 - d3))

exit 0
