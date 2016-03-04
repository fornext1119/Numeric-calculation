# coding: Shift_JIS

import math
 
# ����̎w���֐�
def myExp(x, n, numerator, denominator, y):
    denominator = denominator * n
    numerator   = numerator   * x
    a           = numerator / denominator
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (abs(a) <= 0.00000000001):
        return y
    else:
        return y + myExp(x, n + 1, numerator, denominator, a)

for i in range(0, 21):
    x  = (i - 10) / 4.0
    # �W���̎w���֐�
    d1 = math.exp(x)
    # ����̎w���֐�
    d2 = myExp(x, 1, 1.0, 1.0, 1.0)
    # �W���֐��Ƃ̍���
    print "%5.2f : %13.10f - %13.10f = %13.10f" % (x, d1, d2, d1 - d2)
