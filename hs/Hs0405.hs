-- �㏸�K��p
risingFact x 1 = x
risingFact x n = x * (risingFact (x + 1) (n - 1))
-- 10 ���� 14 �܂ł� ����
risingFact 10 5
