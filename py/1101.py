# coding: Shift_JIS
import math

N = 4

# １次元配列を表示
def disp_vector(row):
    for col in row:
        print "%14.10f\t" % col,
    print ""

# 正規化 (ベクトルの長さを１にする)
def normarize(x):
    s = 0.0

    for i in range(0, N, 1):
        s += x[i] * x[i]
    s = math.sqrt(s)

    for i in range(0, N, 1):
        x[i] /= s

# ベキ乗法
def power(a, x0):
    lambda0 = 0.0

    # 正規化 (ベクトル x0 の長さを１にする)
    normarize(x0)
    e0 = 0.0
    for i in range(0, N, 1):
        e0 += x0[i]

    for k in range(1, 200, 1):
        # １次元配列を表示
        print "%3d\t" % k,
        disp_vector(x0)

        # 行列の積 x1 = A × x0
        x1 =  [ 0.0,  0.0,  0.0,  0.0]
        for i in range(0, N, 1):
            for j in range(0, N, 1):
                x1[i] += a[i][j] * x0[j]

        # 内積
        p0 = 0.0
        p1 = 0.0
        for i in range(0, N, 1):
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]

        # 固有値
        lambda0 = p0 / p1

        # 正規化 (ベクトル x1 の長さを１にする)
        normarize(x1)
        # 収束判定
        e1 = 0.0
        for i in range(0, N, 1):
            e1 += x1[i]
        if (abs(e0 - e1) < 0.00000000001):
            break

        for i in range(0, N, 1):
            x0[i] = x1[i]
        e0 = e1

    return lambda0

# ベキ乗法で最大固有値を求める

a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
x =  [1.0 ,0.0 ,0.0 ,0.0]

# ベキ乗法
lambda0 = power(a, x)

print ""
print "eigenvalue"
print "%14.10f" % lambda0

print "eigenvector"
disp_vector(x)
