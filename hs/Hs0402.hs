-- ��������̐�
prod m d 0 = 1
prod m d n =  m * (prod (m + d) d (n - 1))
-- ���� 5, ���� 3, ���� 10 �̐���̐�
prod 5 3 10
