# データ点の数 - 1
N = 6

# 元の関数
def f(x)
    x - (x ** 3) / (3 * 2) + (x ** 5) / (5 * 4 * 3 * 2)
end

# Newton (ニュートン) 補間
def newton(d, x, a)
    sum = a[0]
    (1..N).each do |i|
        prod = a[i]
        (0..(i - 1)).each do |j|
            if j != i
                prod *= (d - x[j])
			end
		end
        sum += prod
	end
    sum
end

x = Array.new(N)
y = Array.new(N)

# 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
(0..N).each do |i|
    d = i * 1.5 - 4.5
    x[i] = d
    y[i] = f(d)
end

# 差分商の表を作る
d = Array.new(N+1) { Array.new(N) }
(0..N).each do |j|
    d[0][j] = y[j]
end

(1..N).each do |i|
	(0..(N-i)).each do |j|
        d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (x[j+i] - x[j])
	end
end

# ｎ階差分商
a = Array.new(N)
(0..N).each do |j|
    a[j] = d[j][0]
end

# 0.5刻みで 与えられていない値を補間 
(0..18).each do |i|
    d1 = i * 0.5 - 4.5
    d2 = f(d1)
    d3 = newton(d1, x, a)

    # 元の関数と比較
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d1, d2, d3, d2 - d3)
end
