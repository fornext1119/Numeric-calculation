-- ���~�K��p
fallingFact x 1 = x
fallingFact x n = x * (fallingFact (x - 1) (n - 1))
-- 10 ���� 6 �܂ł� ����
fallingFact 10 5
