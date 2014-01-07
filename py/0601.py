# coding: Shift_JIS

import math

def f(x):
    return 4 / (1 + x * x)

a = 0
b = 1

# ��`���Őϕ�
n = 2
for j in range(1, 11):
    h = (b - a) / float(n)
    s = 0
    x = a
    for i in range(1, n):
        x += h
        s += f(x)
    s = h * ((f(a) + f(b)) / 2 + s)
    n *= 2

    # ���ʂ� �� �Ɣ�r
    print "%2d : %13.10f, %13.10f" % (j, s, s - math.pi)
