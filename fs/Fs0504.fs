// ����̎w���֐�
let rec myExp (x:double) (n:int) (numerator:double) (denominator:double) (y:double):double =
    let denom = denominator * (double n)
    let num   = numerator   * x
    let a     = num / denom
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (myExp x (n + 1) num denom a)
[0..20]
|> List.map (fun n -> (double (n - 10)) / 4.0)
|> List.iter
    (fun x -> 
        // �W���̎w���֐�
        let d1 = System.Math.Exp(x)
        // ����̎w���֐�
        let d2 = (myExp x 1 1.0 1.0 1.0)
        // �W���֐��Ƃ̍���
        printfn "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (d1 - d2)
    )
