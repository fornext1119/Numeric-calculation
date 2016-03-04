# coding: Shift_JIS
import math

N = 4

# １次元配列を表示
def disp_vector(row):
    for col in row:
        print "%14.10f\t" % col,
    print ""

# ２次元配列を表示
def disp_matrix(matrix):
    for row in matrix:
        for col in row:
            print "%14.10f\t" % col,
        print ""

# ハウスホルダー変換
def tridiagonalize(a, d, e):
    v =  [0.0 ,0.0 ,0.0 ,0.0]

    for k in range(0, N - 2, 1):
        w = [0.0 ,0.0 ,0.0 ,0.0]
        d[k] = a[k][k]

        t = 0.0
        for i in range(k + 1, N, 1):
            w[i] =  a[i][k]
            t    += w[i] * w[i]
        s = math.sqrt(t)
        if (w[k + 1] < 0):
            s = -s

        if (abs(s) < 0.00000000001):
            e[k + 1] = 0.0
        else:
            e[k + 1]  = -s
            w[k + 1] +=  s
            s = 1 / math.sqrt(w[k + 1] * s)
            for i in range(k + 1, N, 1):
                w[i] *= s

            for i in range(k + 1, N, 1):
                s = 0.0
                for j in range(k + 1, N, 1):
                    if (j <= i):
                        s += a[i][j] * w[j]
                    else:
                        s += a[j][i] * w[j]
                v[i] = s

            s = 0.0
            for i in range(k + 1, N, 1):
                s += w[i] * v[i]
            s /= 2.0
            for i in range(k + 1, N, 1):
                v[i] -= s * w[i]
            for i in range(k + 1, N, 1):
                for j in range(k + 1, i + 1, 1):
                    a[i][j] -= w[i] * v[j] + w[j] * v[i]
            # 次の行は固有ベクトルを求めないなら不要
            for i in range(k + 1, N, 1):
                a[i][k] = w[i]

    d[N - 2] = a[N - 2][N - 2]
    d[N - 1] = a[N - 1][N - 1]

    e[0]     = 0.0
    e[N - 1] = a[N - 1][N - 2]

    # 次の行は固有ベクトルを求めないなら不要
    for k in range(N - 1, -1, -1):
        w = [0.0 ,0.0 ,0.0 ,0.0]
        if (k < N - 2):
            for i in range(k + 1, N, 1):
                w[i] = a[i][k]
            for i in range(k + 1, N, 1):
                s = 0.0
                for j in range(k + 1, N, 1):
                    s += a[i][j] * w[j]
                v[i] = s
            for i in range(k + 1, N, 1):
                for j in range(k + 1, N, 1):
                    a[i][j] -= v[i] * w[j]

        for i in range(0, N, 1):
            a[i][k] = 0.0
        a[k][k] = 1.0

# QR分解
def decomp(a, d, e):
    e[0] = 1.0
    h = N - 1
    while (abs(e[h]) < 0.00000000001):
        h -= 1

    while (h > 0):
        e[0] = 0.0
        l = h - 1
        while (abs(e[l]) >= 0.00000000001):
            l -= 1

        for j in range(1, 100, 1):
            w = (d[h - 1] - d[h]) / 2.0
            s = math.sqrt(w * w + e[h] * e[h])
            if (w < 0.0):
                s = -s

            x = d[l] - d[h] + e[h] * e[h] / (w + s)
            y = e[l + 1]
            z = 0.0
            t = 0.0
            u = 0.0
            for k in range(l, h, 1):
                if (abs(x) >= abs(y)):
                    t = -y / x
                    u = 1 / math.sqrt(t * t + 1.0)
                    s = t * u
                else:
                    t = -x / y
                    s = 1 / math.sqrt(t * t + 1.0)
                    if (t < 0):
                        s = -s
                    u = t * s

                w = d[k] - d[k + 1]
                t = (w * s + 2 * u * e[k + 1]) * s
                d[k    ] = d[k    ] - t
                d[k + 1] = d[k + 1] + t
                e[k    ] = u * e[k] - s * z
                e[k + 1] = e[k + 1] * (u * u - s * s) + w * s * u

                # 次の行は固有ベクトルを求めないなら不要
                for i in range(0, N, 1):
                    x = a[k    ][i]
                    y = a[k + 1][i]
                    a[k    ][i] = u * x - s * y
                    a[k + 1][i] = s * x + u * y

                if (k < N - 2):
                    x = e[k + 1]
                    y = -s * e[k + 2]
                    z = y
                    e[k + 2] = u * e[k + 2]

            print "%3d\t" % j,
            disp_vector(d)

            # 収束判定
            if (abs(e[h]) < 0.00000000001):
                break

        e[0] = 1.0
        while (abs(e[h]) < 0.00000000001):
            h -= 1

    # 次の行は固有ベクトルを求めないなら不要
    for k in range(0, N - 1, 1):
        l = k
        for i in range(k + 1, N, 1):
            if (d[i] > d[l]):
                l = i

        t = d[k]
        d[k] = d[l]
        d[l] = t

        for i in range(0, N, 1):
            t       = a[k][i]
            a[k][i] = a[l][i]
            a[l][i] = t

# ハウスホルダー変換とQR分解で固有値を求める
a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
d =  [1.0 ,0.0 ,0.0 ,0.0]
e =  [1.0 ,0.0 ,0.0 ,0.0]

# ハウスホルダー変換
tridiagonalize(a, d, e)

# QR分解
decomp(a, d, e)

print ""
print "eigenvalue"
disp_vector(d)

print ""
print "eigenvector"
disp_matrix(a)
