// �K��
let rec Fact = function
    |   0 -> 1
    |   n -> n * Fact(n - 1)
// ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
let n = 10
let r = 5
Fact n / Fact (n - r)
// ���~�K��p
let rec FallingFact (x:int) (n:int):int =
    match n with
        | 1 -> x
        | _ -> x * (FallingFact (x - 1) (n - 1))
// ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
let n = 10
let r = 5
FallingFact n r
