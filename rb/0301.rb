# ����:a, ����:a �� ���:lim �̐���̑��a��Ԃ��֐�
def sn(a, lim)
    n = lim / a      # ����:n  =  ���:lim / ����:a
    l = n * a        # ����:l  =  ����:n   * ����:a
    (a + l) * n / 2  # ���a:sn = (����:a   + ����:l) * ����:n / 2
end

# 3 �̔{���̍��v
sum = sn(3, 999)
puts sum
