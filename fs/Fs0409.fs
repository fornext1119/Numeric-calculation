// �g����
let rec Comb(n:int) (r:int):int =
    match n, r with
        | _, 0            -> 1
        | _, 1            -> n
        | _, _ when n = r -> 1
        | _, _            -> Comb (n - 1) (r - 1) + Comb(n - 1) r
// �قȂ� 10 �̂��̂���d���������� 5 ���g�����̑���
let n = 10
let r = 5
Comb (n + r - 1) r
