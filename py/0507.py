# coding: Shift_JIS

import math
 
# ����̑ΐ��֐�
def myLog(x, n, t):
    n2 = n
    x2 = x
    if (n > 3):
        if (n % 2 == 0):
            n2 = 2
        x2 = x * int(n / 2)
    t = x2 / (n2 + t)

    if (n <= 2):
        return x / (1 + t)
    else:
        return myLog(x, n - 1, t)

for i in range(1, 21):
    x  = i / 5.0
    # �W���̑ΐ��֐�
    d1 = math.log(x)
    # ����̑ΐ��֐�
    d2 = myLog(x - 1, 27, 0.0) # 27:�K�v�Ȑ��x��������\���傫�Ȋ
    # �W���֐��Ƃ̍���
    print "%5.2f : %13.10f - %13.10f = %13.10f" % (x, d1, d2, d1 - d2)
