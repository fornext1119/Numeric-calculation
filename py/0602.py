# coding: Shift_JIS

import math

def f(x):
    return 4 / (1 + x * x)

a = 0
b = 1

# 中点則で積分
n = 2
for j in range(1, 11):
    h = (b - a) / float(n)
    s = 0
    x = a + (h / 2)
    for i in range(1, (n + 1)):
        s += f(x)
        x += h
    s *= h
    n *= 2

    # 結果を π と比較
    print "%2d : %13.10f, %13.10f" % (j, s, s - math.pi)
