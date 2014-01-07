// ����̑o�Ȑ������֐�
let rec mySinh (x:double) (n:int) (numerator:double) (denominator:double) (y:double):double =
    let m     = 2 * n
    let denom = denominator * (double (m + 1)) * (double m)
    let num   = numerator   * x * x
    let a     = num / denom
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (mySinh x (n + 1) num denom a)
[0..20]
|> List.map((-) 10)
|> List.iter
    (fun i -> 
        // ����̑o�Ȑ������֐�
        let x  = (double i)
        let d1 = (mySinh x 1 x 1.0 x)
        // �W���̑o�Ȑ������֐�
        let d2 = System.Math.Sinh(x)
        // �W���֐��Ƃ̍���
        printfn "%3d : %17.10f - %17.10f = %13.10f" i d1 d2 (d1 - d2)
    )
