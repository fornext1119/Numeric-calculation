# coding: Shift_JIS

import math
 
# 自作の双曲線余弦関数
def myCosh(x, n, numerator, denominator, y):
    m           = 2 * n
    denominator = denominator * m * (m - 1)
    numerator   = numerator * x * x
    a           = numerator / denominator
    # 十分な精度になったら処理を抜ける
    if (abs(a) <= 0.00000000001):
        return y
    else:
        return y + myCosh(x, n + 1, numerator, denominator, a)

for i in range(0, 21):
    x  = i - 10
    # 自作の双曲線余弦関数
    d1 = myCosh(x, 1, 1.0, 1.0, 1.0)
    # 標準の双曲線余弦関数
    d2 = math.cosh(x)
    # 標準関数との差異
    print "%3d : %17.10f - %17.10f = %13.10f" % (x, d1, d2, d1 - d2)
