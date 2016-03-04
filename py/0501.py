# coding: Shift_JIS

import math
 
# ����̐����֐�
def mySin(x, n, nega, numerator, denominator, y):
    m           = 2 * n
    denominator = denominator * (m + 1) * m
    numerator   = numerator * x * x
    a           = numerator / denominator
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (a <= 0.00000000001):
        return y
    else:
        return y + mySin(x, n + 1, not nega, numerator, denominator, a if nega else -a)
 
for i in range(0, 25):
    degree = i * 15
    if degree % 30 == 0 or degree % 45 == 0:
        radian = math.radians(degree)
        # ����̐����֐�
        d1     = mySin(radian, 1, False, radian, 1.0, radian)
        # �W���̐����֐�
        d2     = math.sin(radian)
        # �W���֐��Ƃ̍���
        print "%3d : %13.10f - %13.10f = %13.10f" % (degree, d1, d2, d1 - d2)
