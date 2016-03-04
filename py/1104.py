# coding: Shift_JIS
import math

N = 4

# 対角要素を表示
def disp_eigenvalue(a):
    for i in range(0, N, 1):
        print "%14.10f\t" % a[i][i],
    print ""

# 行列の積
def multiply(a, b, c):
    for i in range(0, N, 1):
        for j in range(0, N, 1):
            s = 0.0
            for k in range(0, N, 1):
                s += a[i][k] * b[k][j]
            c[i][j] = s

# QR分解
def decomp(a, q, r):
    x = [0.0 ,0.0 ,0.0 ,0.0]

    for k in range(0, N, 1):
        for i in range(0, N, 1):
            x[i] = a[i][k]

        for j in range(0, k, 1):
            t = 0.0
            for i in range(0, N, 1):
                t += a[i][k] * q[i][j]
            r[j][k] = t
            r[k][j] = 0.0
            for i in range(0, N, 1):
                x[i] -= t * q[i][j]

        s = 0.0
        for i in range(0, N, 1):
            s += x[i] * x[i]
        r[k][k] = math.sqrt(s)
        for i in range(0, N, 1):
            q[i][k] = x[i] / r[k][k]

# QR分解で固有値を求める

a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
q = [[0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0]]
r = [[0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0]]

for k in range(1, 200, 1):
    # QR分解
    decomp(a, q, r)
    # 行列の積
    multiply(r, q, a)
    # 対角要素を表示
    print "%3d\t" % k,
    disp_eigenvalue(a)

    # 収束判定
    e = 0.0
    for i in range(1, N, 1):
        for j in range(0, i, 1):
            e += abs(a[i][j])
    if (e < 0.00000000001):
        break

print ""
print "eigenvalue"
disp_eigenvalue(a)
