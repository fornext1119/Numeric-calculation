// ����̑ΐ��֐�
let rec myLog (x2:double) (numerator:double) (denominator:double) (y:double):double =
    let denom = denominator + 2.0
    let num   = numerator   * x2 * x2
    let a     = num / denom
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if abs(a) <= 0.00000000001 then
        y
    else
        y + (myLog x2 num denom a)
[1..20]
|> List.map  (fun n -> (double n) / 5.0)
|> List.iter
    (fun x -> 
        // �W���̑ΐ��֐�
        let d1 = System.Math.Log(x)
        // ����̑ΐ��֐�
        let x2 = (x - 1.0) / (x + 1.0)
        let d2 = 2.0 * (myLog x2 x2 1.0 x2)
        // �W���֐��Ƃ̍���
        printfn "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (d1 - d2)
    )
