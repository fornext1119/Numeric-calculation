// ����̎w���֐�
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
        // �W���̎w���֐�
        let d1 = System.Math.Exp(x)
        // ����̎w���֐�
        let x2 = x * x
        let d2 = (myExp x x2 30 0.0) // 30:�K�v�Ȑ��x��������悤, 6����n�߂�4������������
        // �W���֐��Ƃ̍���
        printfn "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (d1 - d2)
    )
