# coding: Shift_JIS
import math

N = 4

# �Ίp�v�f��\��
def disp_eigenvalue(a):
    for i in range(0, N, 1):
        print "%14.10f\t" % a[i][i],
    print ""

# �s��̐�
def multiply(a, b, c):
    for i in range(0, N, 1):
        for j in range(0, N, 1):
            s = 0.0
            for k in range(0, N, 1):
                s += a[i][k] * b[k][j]
            c[i][j] = s

# LU����
def decomp(a, l, u):
    for i in range(0, N, 1):
        for j in range(0, N, 1):
            l[i][j] = 0.0
            u[i][j] = 0.0

    l[0][0] = 1.0
    for j in range(0, N, 1):
        u[0][j] = a[0][j]

    for i in range(1, N, 1):
        u[i][0] = 0.0
        l[0][i] = 0.0
        l[i][0] = a[i][0] / u[0][0]

    for i in range(1, N, 1):
        l[i][i] = 1.0
        t = a[i][i]
        for k in range(0, i + 1, 1):
            t -= l[i][k] * u[k][i]
        u[i][i] = t
        for j in range(i + 1, N, 1):
            u[j][i] = 0.0
            l[i][j] = 0.0
            t       = a[j][i]
            for k in range(0, i + 1, 1):
                t -= l[j][k] * u[k][i]
            l[j][i] = t / u[i][i]
            t       = a[i][j]
            for k in range(0, i + 1, 1):
                t -= l[i][k] * u[k][j]
            u[i][j] = t

# LR�����ŌŗL�l�����߂�

a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
l = [[0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0]]
u = [[0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0]]

for k in range(1, 200, 1):
    # LU����
    decomp(a, l, u)
    # �s��̐�
    multiply(u, l, a)
    # �Ίp�v�f��\��
    print "%3d\t" % k,
    disp_eigenvalue(a)

    # ��������
    e = 0.0
    for i in range(1, N, 1):
        for j in range(0, i, 1):
            e += abs(a[i][j])
    if (e < 0.00000000001):
        break

print ""
print "eigenvalue"
disp_eigenvalue(a)
