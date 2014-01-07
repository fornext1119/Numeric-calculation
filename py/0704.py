# coding: Shift_JIS

# �f�[�^�_�̐�
N   =  7
Nx2 = 14

# ���̊֐�
def f(x):
    return x - (x ** 3) / (3 * 2) + (x ** 5) / (5 * 4 * 3 * 2)

# ���֐�
def fd(x):
    return 1 - (x ** 2) / 2 + (x ** 4) / (4 * 3 * 2)

# Hermite (�G���~�[�g) ���
def hermite(d, z, a):
    sum = a[0]
    for i in range(1, Nx2):
        prod = a[i]
        for j in range(0, i):
            prod *= (d - z[j])
        sum += prod
    return sum

x  = [0 for i in range(N)]
y  = [0 for i in range(N)]
yd = [0 for i in range(N)]

# 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
for i in range(0, N):
    d = i * 1.5 - 4.5
    x[i]  = d
    y[i]  = f(d)
    yd[i] = fd(d)

# �������̕\�����
z =  [0 for i in range(Nx2)]
d = [[0 for j in range(Nx2)] for i in range(Nx2)]
for i in range(0, Nx2):
    j       = int(i / 2)
    z[i]    = x[j]
    d[0][i] = y[j]

for i in range(1, Nx2):
    for j in range(0, Nx2 - i):
        if (i == 1 and j % 2 == 0):
            d[i][j] = yd[int(j / 2)]
        else:
            d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (z[j+i] - z[j])

# ���K������
a = [0 for i in range(Nx2)]
for j in range(0, Nx2):
    a[j] = d[j][0]

# 0.5���݂� �^�����Ă��Ȃ��l���� 
for i in range(0, 19):
    d1 = i * 0.5 - 4.5
    d2 = f(d1)
    d3 = hermite(d1, z, a)

    # ���̊֐��Ɣ�r
    print "%5.2f\t%8.5f\t%8.5f\t%8.5f" % (d1, d2, d3, d2 - d3)
