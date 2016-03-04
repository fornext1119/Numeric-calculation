# coding: Shift_JIS

# 階乗を求める関数
def Fact(n):
    if (n <= 1):
        return 1
    else:
        return n * Fact(n - 1)

# 10の階乗
print Fact(10)
print 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1
