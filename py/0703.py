# coding: Shift_JIS

# データ点の数
N = 7

# 元の関数
def f(x):
    return x - (x ** 3) / (3 * 2) + (x ** 5) / (5 * 4 * 3 * 2)

# Newton (ニュートン) 補間
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

# 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
for i in range(0, N):
    d = i * 1.5 - 4.5
    x[i] = d
    y[i] = f(d)

# 差分商の表を作る
d = [[0 for j in range(N)] for i in range(N)]
for j in range(0, N):
    d[0][j] = y[j]

for i in range(1, N):
    for j in range(0, N - i):
        d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (x[j+i] - x[j])

# ｎ階差分商
a = [0 for i in range(N)]
for j in range(0, N):
    a[j] = d[j][0]

# 0.5刻みで 与えられていない値を補間 
for i in range(0, 19):
    d1 = i * 0.5 - 4.5
    d2 = f(d1)
    d3 = newton(d1, x, a)

    # 元の関数と比較
    print "%5.2f\t%8.5f\t%8.5f\t%8.5f" % (d1, d2, d3, d2 - d3)
