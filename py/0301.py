# coding: Shift_JIS

# ����:a, ����:a �� ���:lim �̐���̑��a��Ԃ��֐�
def sn(a, lim):
    n = int(lim) / a        # ����:n  =  ���:lim / ����:a
    l = n * a               # ����:l  =  ����:n   * ����:a
    return (a + l) * n / 2  # ���a:sn = (����:a   + ����:l) * ����:n / 2

# 3 �̔{���̍��v
print sn(3, 999)
