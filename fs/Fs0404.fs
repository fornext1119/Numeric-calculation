// ���~�K��p
let rec FallingFact (x:int) (n:int):int =
    match n with
        | 1 -> x
        | _ -> x * (FallingFact (x - 1) (n - 1))
// 10 ���� 6 �܂ł� ����
FallingFact 10 5
