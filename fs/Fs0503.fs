// 自作の正接関数
let rec myTan (x:double) (x2:double) (n:int) (t:double):double =
    let denom = x2 / ((double n) - t)
    let num   = n - 2
    if num <= 1 then 
        x / (1.0 - denom)
    else
        myTan x x2 num denom
[0..12]
|> List.map    ((*) 15)
|> List.filter (fun n -> n % 180 <> 0)
|> List.map    ((-) 90)
|> List.iter
    (fun degree -> 
        let radian = (double degree) * System.Math.PI / 180.0
        let x2     = radian * radian
        // 自作の正接関数
        let d1 = (myTan radian x2 15 0.0) // 15:必要な精度が得られる十分大きな奇数
        // 標準の正接関数
        let d2 = System.Math.Tan(radian)
        // 標準関数との差異
        printfn "%3d : %13.10f - %13.10f = %13.10f" degree d1 d2 (d1 - d2)
    )
