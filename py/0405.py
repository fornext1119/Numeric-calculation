# �㏸�K��p
def RisingFact(x, n):
    if (n <= 1):
        return x
    else:
        return x * RisingFact(x + 1, n - 1)

# 10 ���� 14 �܂ł� ����
print RisingFact(10, 5)
print 10 * 11 * 12 * 13 * 14
