a = 5  # ���� 5
d = 3  # ���� 3
n = 10 # ���� 10
p = 1  # ��

for i in range(1, n + 1):
    m = a + (d * (i - 1))
    p *= m
print p
