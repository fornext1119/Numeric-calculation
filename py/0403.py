# coding: Shift_JIS

# �K������߂�֐�
def Fact(n):
    if (n <= 1):
        return 1
    else:
        return n * Fact(n - 1)

# 10�̊K��
print Fact(10)
print 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1
