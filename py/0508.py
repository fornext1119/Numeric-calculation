# coding: Shift_JIS

import math
 
# ����̑o�Ȑ������֐�
def mySinh(x, n, numerator, denominator, y):
    m           = 2 * n
    denominator = denominator * (m + 1) * m
    numerator   = numerator * x * x
    a           = numerator / denominator
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (abs(a) <= 0.00000000001):
        return y
    else:
        return y + mySinh(x, n + 1, numerator, denominator, a)

for i in range(0, 21):
    x  = i - 10
    # ����̑o�Ȑ������֐�
    d1 = mySinh(x, 1, x, 1.0, x)
    # �W���̑o�Ȑ������֐�
    d2 = math.sinh(x)
    # �W���֐��Ƃ̍���
    print "%3d : %17.10f - %17.10f = %13.10f" % (x, d1, d2, d1 - d2)
