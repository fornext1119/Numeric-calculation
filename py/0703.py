# coding: Shift_JIS

# �f�[�^�_�̐�
N = 7

# ���̊֐�
def f(x):
    return x - (x ** 3) / (3 * 2) + (x ** 5) / (5 * 4 * 3 * 2)

# Newton (�j���[�g��) ���
def newton(d, x, a):
    sum = a[0]
    for i in range(1, N):
        prod = a[i]
        for j in range(0, i):
            prod *= (d - x[j])
        sum += prod
    return sum

x = [0 for i in range(N)]
y = [0 for i in range(N)]

# 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
for i in range(0, N):
    d = i * 1.5 - 4.5
    x[i] = d
    y[i] = f(d)

# �������̕\�����
d = [[0 for j in range(N)] for i in range(N)]
for j in range(0, N):
    d[0][j] = y[j]

for i in range(1, N):
    for j in range(0, N - i):
        d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (x[j+i] - x[j])

# ���K������
a = [0 for i in range(N)]
for j in range(0, N):
    a[j] = d[j][0]

# 0.5���݂� �^�����Ă��Ȃ��l���� 
for i in range(0, 19):
    d1 = i * 0.5 - 4.5
    d2 = f(d1)
    d3 = newton(d1, x, a)

    # ���̊֐��Ɣ�r
    print "%5.2f\t%8.5f\t%8.5f\t%8.5f" % (d1, d2, d3, d2 - d3)
