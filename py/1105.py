# coding: Shift_JIS
import math

N = 4

# 対角要素を表示
def disp_eigenvalue(a):
    for i in range(0, N, 1):
        print "%14.10f\t" % a[i][i],
    print ""

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

# 固有ベクトルを表示
def disp_eigenvector(matrix):
    for i in range(0, N, 1):
        row = [0.0 ,0.0 ,0.0 ,0.0]
        for j in range(0, N, 1):
            row[j] = matrix[i][j]
        normarize(row)
        disp_vector(row)

# ヤコビ法
def jacobi(a, v):
    for k in range(1, 200, 1):
        # 最大値を探す
        p = 0
        q = 0
        max_val = 0.0
        for i in range(0, N, 1):
            for j in range(i + 1, N, 1):
                if (max_val < abs(a[i][j])):
                    max_val = abs(a[i][j])
                    p = i
                    q = j

        # θ を求める
        t = 0.0
        if (abs(a[p][p] - a[q][q]) < 0.00000000001):
            # a_{pp} ＝ a_{qq} のとき、回転角ｔをπ/4にする
            t = math.pi / 4.0
            if (a[p][p] < 0):
                t = -t
        else:
            # a_{pp} ≠ a_{qq} のとき
            t = math.atan(2.0 * a[p][q] / (a[p][p] - a[q][q])) / 2.0

        # θ を使って 行列 U を作成し、A = U^t × A × U
        c = math.cos(t)
        s = math.sin(t)
        # U^t × A
        t1 = 0.0
        t2 = 0.0
        for i in range(0, N, 1):
            t1      =  a[p][i] * c + a[q][i] * s
            t2      = -a[p][i] * s + a[q][i] * c
            a[p][i] = t1
            a[q][i] = t2
            # 固有ベクトル
            t1      =  v[p][i] * c + v[q][i] * s
            t2      = -v[p][i] * s + v[q][i] * c
            v[p][i] = t1
            v[q][i] = t2
        # A × U
        for i in range(0, N, 1):
            t1      =  a[i][p] * c + a[i][q] * s
            t2      = -a[i][p] * s + a[i][q] * c
            a[i][p] = t1
            a[i][q] = t2

        # 対角要素を表示
        print "%3d\t" % k,
        disp_eigenvalue(a)

        # 収束判定
        if (max_val < 0.00000000001):
            break

# ヤコビ法で固有値を求める
a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
v = [[1.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,1.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,1.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,1.0]]

# ヤコビ法
jacobi(a, v)

print ""
print "eigenvalue"
disp_eigenvalue(a)

print ""
print "eigenvector"
disp_eigenvector(v)
