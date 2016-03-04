// ����̑ΐ��֐�
let rec myLog (x:double) (n:int) (t:double):double =
    let mutable n2 = n
    let mutable x2 = x
    if n > 3 then
        if n % 2 = 0 then
            n2 <- 2
        x2 <- x * (double (n / 2))

    let t2 = x2 / ((double n2) + t)

    if n <= 2 then
        x / (1.0 + t2)
    else
        myLog x (n - 1) t2
[1..20]
|> List.map (fun n -> (double n) / 5.0)
|> List.iter
    (fun x -> 
        // �W���̑ΐ��֐�
        let d1 = System.Math.Log(x)
        // ����̑ΐ��֐�
        let d2 = (myLog (x - 1.0) 27 0.0) // 27:�K�v�Ȑ��x��������\���傫�Ȋ
        // �W���֐��Ƃ̍���
        printfn "%5.2f : %13.10f - %13.10f = %13.10f" x d1 d2 (d1 - d2)
    )
