// ����̑o�Ȑ��]���֐�
let rec myCosh (x:double) (n:int) (numerator:double) (denominator:double) (y:double):double =
    let m     = 2 * n
    let denom = denominator * (double m) * (double (m - 1))
    let num   = numerator   * x * x
    let a     = num / denom
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (myCosh x (n + 1) num denom a)
[0..20]
|> List.map((-) 10)
|> List.iter
    (fun i -> 
        let x  = (double i)
        // ����̑o�Ȑ��]���֐�
        let d1 = (myCosh x 1 1.0 1.0 1.0)
        // �W���̑o�Ȑ��]���֐�
        let d2 = System.Math.Cosh(x)
        // �W���֐��Ƃ̍���
        printfn "%3d : %17.10f - %17.10f = %13.10f" i d1 d2 (d1 - d2)
    )
