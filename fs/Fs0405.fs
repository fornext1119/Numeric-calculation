// �㏸�K��p
let rec RisingFact (x:int) (n:int):int =
    match n with
        | 1 -> x
        | _ -> x * (RisingFact (x + 1) (n - 1))
// 10 ���� 14 �܂ł� ����
RisingFact 10 5
