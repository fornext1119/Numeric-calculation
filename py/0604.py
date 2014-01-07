# coding: Shift_JIS

import math

def f(x):
    return 4 / (1 + x * x)

a = 0
b = 1

t = [[0 for j in range(7)] for i in range(7)]

# 台形則で積分
n = 2
for i in range(1, 7):
    h = (b - a) / float(n)
    s = 0
    x = a
    for j in range(1, n):
        x += h
        s += f(x)
    # 結果を保存
    t[i][1] = h * ((f(a) + f(b)) / 2 + s)
    n *= 2

# Richardsonの補外法
n = 4
for j in range(2, 7):
    for i in range(j, 7):
        t[i][j] = t[i][j - 1] + (t[i][j - 1] - t[i - 1][j - 1]) / (n - 1)
        if (i == j):
            # 結果を π と比較
            print "%2d : %13.10f, %13.10f" % (j, t[i][j], t[i][j] - math.pi)
    n *= 4
