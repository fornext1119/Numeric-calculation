-- �K��
fact 0 = 1
fact n = n * fact (n-1)
-- ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
let n = 10
let r = 5
(fact n) `div` (fact (n - r))
-- ���~�K��p
fallingFact x 1 = x
fallingFact x n = x * (fallingFact (x - 1) (n - 1))
-- ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
let n = 10
let r = 5
fallingFact n r
