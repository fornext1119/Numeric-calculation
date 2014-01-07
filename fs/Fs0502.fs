// 自作の余弦関数
let rec myCos (x:double) (n:int) (nega:bool) (numerator:double) (denominator:double) (y:double):double =
    let m     = 2 * n
    let denom = denominator * (double m) * (double (m - 1))
    let num   = numerator   * x * x
    let a     = num / denom
    // 十分な精度になったら処理を抜ける
    if a <= 0.00000000001 then
        y
    else
        y + (myCos x (n + 1) (not nega) num denom (if nega then a else -a) )
[0..24]
|> List.map    ((*) 15)
|> List.filter (fun n -> (n % 30 = 0) || (n % 45 = 0))
|> List.iter
    (fun degree -> 
        let radian = (double degree) * System.Math.PI / 180.0
        // 自作の余弦関数
        let d1 = (myCos radian 1 false 1.0 1.0 1.0)
        // 標準の余弦関数
        let d2 = System.Math.Cos(radian)
        // 標準関数との差異
        printfn "%3d : %13.10f - %13.10f = %13.10f" degree d1 d2 (d1 - d2)
    )
