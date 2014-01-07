// 自作の指数関数
let rec myExp (x:double) (x2:double) (n:int) (t:double):double =
    let denom = x2 / ((double n) + t)
    let num   = n - 4;

    if num < 6 then 
        1.0 + ((2.0 * x) / (2.0 - x + denom))
    else
        myExp x x2 num denom
[0..20]
|> List.map    (fun n -> (double (n - 10)) / 4.0)
|> List.iter
    (fun x -> 
        // 標準の指数関数
        let d1 = System.Math.Exp(x)
        // 自作の指数関数
        let x2 = x * x
        let d2 = (myExp x x2 30 0.0) // 30:必要な精度が得られるよう, 6から始めて4ずつ増加させる
        // 標準関数との差異
        printfn "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (d1 - d2)
    )
