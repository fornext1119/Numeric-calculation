# coding: Shift_JIS

import math
 
# 自作の余弦関数
def myCos(x, n, nega, numerator, denominator, y):
    m           = 2 * n
    denominator = denominator * m * (m - 1)
    numerator   = numerator * x * x
    a           = numerator / denominator
    # 十分な精度になったら処理を抜ける
    if (a <= 0.00000000001):
        return y
    else:
        return y + myCos(x, n + 1, not nega, numerator, denominator, a if nega else -a)
 
for i in range(0, 25):
    degree = i * 15
    if degree % 30 == 0 or degree % 45 == 0:
        radian = math.radians(degree)
        # 自作の余弦関数
        d1     = myCos(radian, 1, False, 1.0, 1.0, 1.0)
        # 標準の余弦関数
        d2     = math.cos(radian)
        # 標準関数との差異
        print "%3d : %13.10f - %13.10f = %13.10f" % (degree, d1, d2, d1 - d2)
