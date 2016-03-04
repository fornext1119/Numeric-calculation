# coding: Shift_JIS
import math

N = 4

# 前進消去
def forward_elimination(a):
    for pivot in range(0, N - 1, 1):
        for row in range(pivot + 1, N, 1):
            s = a[row][pivot] / a[pivot][pivot]
            for col in range(pivot, N, 1):
                a[row][col] -= a[pivot][col]    * s # これが 上三角行列
            a[row][pivot]    = s                    # これが 下三角行列

# 前進代入
def forward_substitution(a, y, b):
    for row in range(0, N, 1):
        for col in range(0, row, 1):
            b[row] -= a[row][col] * y[col]

        y[row] = b[row]

# 後退代入
def backward_substitution(a, x, y):
    for row in range(N - 1, -1, -1):
        for col in range(N - 1, row, -1):
            y[row] -= a[row][col] * x[col]
        x[row] = y[row] / a[row][row]


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

# 逆ベキ乗法
def inverse(a, x0):
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

        # Ly=b から y を求める (前進代入)
        y = [0.0, 0.0, 0.0, 0.0]
        b = [0.0, 0.0, 0.0, 0.0]
        for i in range(0, N, 1):
            b[i] = x0[i]
        forward_substitution(a, y, b)

        # Ux=y から x を求める (後退代入)
        x1 =  [ 0.0,  0.0,  0.0,  0.0]
        backward_substitution(a, x1, y)

        # 内積
        p0 = 0.0
        p1 = 0.0
        for i in range(0, N, 1):
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]

        # 固有値
        lambda0 = p1 / p0

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

# 逆ベキ乗法で最小固有値を求める

a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
x =  [1.0 ,0.0 ,0.0 ,0.0]

# LU分解
forward_elimination(a)

# 逆ベキ乗法
lambda0 = inverse(a, x)

print ""
print "eigenvalue"
print "%14.10f" % lambda0

print "eigenvector"
disp_vector(x)
