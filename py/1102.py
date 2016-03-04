# coding: Shift_JIS
import math

N = 4

# �O�i����
def forward_elimination(a):
    for pivot in range(0, N - 1, 1):
        for row in range(pivot + 1, N, 1):
            s = a[row][pivot] / a[pivot][pivot]
            for col in range(pivot, N, 1):
                a[row][col] -= a[pivot][col]    * s # ���ꂪ ��O�p�s��
            a[row][pivot]    = s                    # ���ꂪ ���O�p�s��

# �O�i���
def forward_substitution(a, y, b):
    for row in range(0, N, 1):
        for col in range(0, row, 1):
            b[row] -= a[row][col] * y[col]

        y[row] = b[row]

# ��ޑ��
def backward_substitution(a, x, y):
    for row in range(N - 1, -1, -1):
        for col in range(N - 1, row, -1):
            y[row] -= a[row][col] * x[col]
        x[row] = y[row] / a[row][row]


# �P�����z���\��
def disp_vector(row):
    for col in row:
        print "%14.10f\t" % col,
    print ""

# ���K�� (�x�N�g���̒������P�ɂ���)
def normarize(x):
    s = 0.0

    for i in range(0, N, 1):
        s += x[i] * x[i]
    s = math.sqrt(s)

    for i in range(0, N, 1):
        x[i] /= s

# �t�x�L��@
def inverse(a, x0):
    lambda0 = 0.0

    # ���K�� (�x�N�g�� x0 �̒������P�ɂ���)
    normarize(x0)
    e0 = 0.0
    for i in range(0, N, 1):
        e0 += x0[i]

    for k in range(1, 200, 1):
        # �P�����z���\��
        print "%3d\t" % k,
        disp_vector(x0)

        # Ly=b ���� y �����߂� (�O�i���)
        y = [0.0, 0.0, 0.0, 0.0]
        b = [0.0, 0.0, 0.0, 0.0]
        for i in range(0, N, 1):
            b[i] = x0[i]
        forward_substitution(a, y, b)

        # Ux=y ���� x �����߂� (��ޑ��)
        x1 =  [ 0.0,  0.0,  0.0,  0.0]
        backward_substitution(a, x1, y)

        # ����
        p0 = 0.0
        p1 = 0.0
        for i in range(0, N, 1):
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]

        # �ŗL�l
        lambda0 = p1 / p0

        # ���K�� (�x�N�g�� x1 �̒������P�ɂ���)
        normarize(x1)
        # ��������
        e1 = 0.0
        for i in range(0, N, 1):
            e1 += x1[i]
        if (abs(e0 - e1) < 0.00000000001):
            break

        for i in range(0, N, 1):
            x0[i] = x1[i]
        e0 = e1

    return lambda0

# �t�x�L��@�ōŏ��ŗL�l�����߂�

a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
x =  [1.0 ,0.0 ,0.0 ,0.0]

# LU����
forward_elimination(a)

# �t�x�L��@
lambda0 = inverse(a, x)

print ""
print "eigenvalue"
print "%14.10f" % lambda0

print "eigenvector"
disp_vector(x)
