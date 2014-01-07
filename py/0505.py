# coding: Shift_JIS

import math
 
# ����̎w���֐�
def myExp(x, x2, n, t):
    t = x2 / (n + t)
    n -= 4  

    if (n < 6):
        return 1 + ((2 * x) / (2 - x + t))
    else:
        return myExp(x, x2, n, t)

for i in range(0, 21):
    x  = (i - 10) / 4.0
    # �W���̎w���֐�
    d1 = math.exp(x)
    # ����̎w���֐�
    x2 = x * x
    d2 = myExp(x, x2, 30, 0.0) # 30:�K�v�Ȑ��x��������悤, 6����n�߂�4������������
    # �W���֐��Ƃ̍���
    print "%5.2f : %13.10f - %13.10f = %13.10f" % (x, d1, d2, d1 - d2)
