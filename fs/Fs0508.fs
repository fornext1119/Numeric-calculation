// ©ì‚Ì‘o‹Èü³Œ·ŠÖ”
let rec mySinh (x:double) (n:int) (numerator:double) (denominator:double) (y:double):double =
    let m     = 2 * n
    let denom = denominator * (double (m + 1)) * (double m)
    let num   = numerator   * x * x
    let a     = num / denom
    // \•ª‚È¸“x‚É‚È‚Á‚½‚çˆ—‚ğ”²‚¯‚é
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (mySinh x (n + 1) num denom a)
[0..20]
|> List.map((-) 10)
|> List.iter
    (fun i -> 
        // ©ì‚Ì‘o‹Èü³Œ·ŠÖ”
        let x  = (double i)
        let d1 = (mySinh x 1 x 1.0 x)
        // •W€‚Ì‘o‹Èü³Œ·ŠÖ”
        let d2 = System.Math.Sinh(x)
        // •W€ŠÖ”‚Æ‚Ì·ˆÙ
        printfn "%3d : %17.10f - %17.10f = %13.10f" i d1 d2 (d1 - d2)
    )
