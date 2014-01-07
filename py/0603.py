# coding: Shift_JIS

import math

def f(x):
    return 4 / (1 + x * x)

a = 0
b = 1

# Simpson則で積分
n = 2
for j in range(1, 6):
    h  = (b - a) / float(n)
    s2 = 0
    s4 = 0
    x  = a + h
    for i in range(1, (n / 2 + 1)):
        s4 += f(x)
        x  += h
        s2 += f(x)
        x  += h
    s2 = (s2 - f(b)) * 2 + f(a) + f(b)
    s4 *= 4
    s  = (s2 + s4) * h / 3
    n  *= 2

    # 結果を π と比較
    print "%2d : %13.10f, %13.10f" % (j, s, s - math.pi)
