# coding: Shift_JIS

# データ点の数
N = 7

# 元の関数
def f(x):
    return x - (x ** 3) / (3 * 2) + (x ** 5) / (5 * 4 * 3 * 2)

# Neville (ネヴィル) 補間
def neville(d, x, y):
    w = [[0 for j in range(N)] for i in range(N)]
    for i in range(0, N):
        w[0][i] = y[i]

    for j in range(1, N):
        for i in range(0, N - j):
            w[j][i] = w[j-1][i+1] + (w[j-1][i+1] - w[j-1][i]) * (d - x[i+j]) / (x[i+j] - x[i])

    return w[N-1][0]

x = [0 for i in range(N)]
y = [0 for i in range(N)]

# 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
for i in range(0, N):
    d = i * 1.5 - 4.5
    x[i] = d
    y[i] = f(d)

# 0.5刻みで 与えられていない値を補間 
for i in range(0, 19):
    d  = i * 0.5 - 4.5
    d1 = f(d)
    d2 = neville(d, x, y)

    # 元の関数と比較
    print "%5.2f\t%8.5f\t%8.5f\t%8.5f" % (d, d1, d2, d1 - d2)
