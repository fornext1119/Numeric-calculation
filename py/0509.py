# coding: Shift_JIS

import math
 
# ����̑o�Ȑ��]���֐�
def myCosh(x, n, numerator, denominator, y):
    m           = 2 * n
    denominator = denominator * m * (m - 1)
    numerator   = numerator * x * x
    a           = numerator / denominator
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (abs(a) <= 0.00000000001):
        return y
    else:
        return y + myCosh(x, n + 1, numerator, denominator, a)

for i in range(0, 21):
    x  = i - 10
    # ����̑o�Ȑ��]���֐�
    d1 = myCosh(x, 1, 1.0, 1.0, 1.0)
    # �W���̑o�Ȑ��]���֐�
    d2 = math.cosh(x)
    # �W���֐��Ƃ̍���
    print "%3d : %17.10f - %17.10f = %13.10f" % (x, d1, d2, d1 - d2)
