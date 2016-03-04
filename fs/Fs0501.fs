// ����̐����֐�
let rec mySin (x:double) (n:int) (nega:bool) (numerator:double) (denominator:double) (y:double):double =
    let m     = 2 * n
    let denom = denominator * (double (m + 1)) * (double m)
    let num   = numerator   * x * x
    let a     = num / denom
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if a <= 0.00000000001 then
        y
    else
        y + (mySin x (n + 1) (not nega) num denom (if nega then a else -a) )
[0..24]
|> List.map    (fun n -> n * 15)
|> List.filter (fun n -> (n % 30 = 0) || (n % 45 = 0))
|> List.iter
    (fun degree -> 
        let radian = (double degree) * System.Math.PI / 180.0
        // ����̐����֐�
        let d1 = (mySin radian 1 false radian 1.0 radian)
        // �W���̐����֐�
        let d2 = System.Math.Sin(radian)
        // �W���֐��Ƃ̍���
        printfn "%3d : %13.10f - %13.10f = %13.10f" degree d1 d2 (d1 - d2)
    )
