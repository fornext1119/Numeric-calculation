# データ点の数 - 1
N = 6

# 元の関数
def f(x)
    x - (x ** 3) / (3 * 2) + (x ** 5) / (5 * 4 * 3 * 2)
end

# Spline (スプライン) 補間
def spline(d, x, y, z)
    # 補間関数値がどの区間にあるか
    k = -1
	(1..N).each do |i|
        if d <= x[i]
            k = i - 1
            break
        end
    end
    if k < 0 
		k = N
	end

    d1 =  x[k+1] - d
    d2 =  d      - x[k]
    d3 =  x[k+1] - x[k]
    (z[k] * (d1 ** 3) + z[k+1] * (d2 ** 3)) / (6.0 * d3) +
    (y[k]   / d3 - z[k]   * d3 / 6.0) * d1               +
    (y[k+1] / d3 - z[k+1] * d3 / 6.0) * d2
end

x = Array.new(N)
y = Array.new(N)

# 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
(0..N).each do |i|
    d = i * 1.5 - 4.5
    x[i] = d
    y[i] = f(d)
end

# ３項方程式の係数の表を作る
a = Array.new(N)
b = Array.new(N)
c = Array.new(N)
d = Array.new(N)
(1..(N - 1)).each do |i|
    a[i] =         x[i]   - x[i-1]
    b[i] = 2.0 *  (x[i+1] - x[i-1])
    c[i] =         x[i+1] - x[i]
    d[i] = 6.0 * ((y[i+1] - y[i]) / (x[i+1] - x[i]) - (y[i] - y[i-1]) / (x[i] - x[i-1]))
end
# ３項方程式を解く (ト－マス法)
g = Array.new(N)
s = Array.new(N)
g[1] = b[1]
s[1] = d[1]
(2..(N - 1)).each do |i|
    g[i] = b[i] - a[i] * c[i-1] / g[i-1]
    s[i] = d[i] - a[i] * s[i-1] / g[i-1]
end
z = Array.new(N)
z[0]   = 0
z[N]   = 0
z[N-1] = s[N-1] / g[N-1]
i = N - 2
while i > 0 do
    z[i] = (s[i] - c[i] * z[i+1]) / g[i]
	i -= 1
end

# 0.5刻みで 与えられていない値を補間 
(0..18).each do |i|
    d1 = i * 0.5 - 4.5
    d2 = f(d1)
    d3 = spline(d1, x, y, z)

    # 元の関数と比較
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d1, d2, d3, d2 - d3)
end
