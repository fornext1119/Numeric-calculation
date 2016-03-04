# coding: Shift_JIS
import math

N = 4

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

# �x�L��@
def power(a, x0):
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

        # �s��̐� x1 = A �~ x0
        x1 =  [ 0.0,  0.0,  0.0,  0.0]
        for i in range(0, N, 1):
            for j in range(0, N, 1):
                x1[i] += a[i][j] * x0[j]

        # ����
        p0 = 0.0
        p1 = 0.0
        for i in range(0, N, 1):
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]

        # �ŗL�l
        lambda0 = p0 / p1

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

# �x�L��@�ōő�ŗL�l�����߂�

a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
x =  [1.0 ,0.0 ,0.0 ,0.0]

# �x�L��@
lambda0 = power(a, x)

print ""
print "eigenvalue"
print "%14.10f" % lambda0

print "eigenvector"
disp_vector(x)
