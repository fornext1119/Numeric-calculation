-- �g����
comb n 0 = 1
comb n 1 = n
comb n r
    | n == r    = 1
    | otherwise = (comb (n - 1) (r - 1)) + (comb (n - 1) r)
-- �قȂ� 10 �̂��̂���d���������� 5 ����Ăł���g�����̑���
let n = 10
let r = 5
comb (n + r - 1) r
