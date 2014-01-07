# coding: Shift_JIS

import math
 
# ����̐��ڊ֐�
def myTan(x, x2, n, t):
    t = x2 / (n - t)
    n -= 2  
    if (n <= 1): 
        return x / (1 - t)
    else:
        return myTan(x, x2, n, t)

for i in range(0, 13):
    if i * 15 % 180 != 0:
        degree = i * 15 - 90
        radian = math.radians(degree)
        x2     = radian * radian
        # ����̐��ڊ֐�
        d1     = myTan(radian, x2, 15, 0.0) # 15:�K�v�Ȑ��x��������\���傫�Ȋ
        # �W���̐��ڊ֐�
        d2     = math.tan(radian)
        # �W���֐��Ƃ̍���
        print "%3d : %13.10f - %13.10f = %13.10f" % (degree, d1, d2, d1 - d2)
