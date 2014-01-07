# データ点の数 - 1
N   =  6
Nx2 = 13

# 元の関数
def f(x)
    x - (x ** 3) / (3 * 2) + (x ** 5) / (5 * 4 * 3 * 2)
end

# 導関数
def fd(x)
    1 - (x ** 2) / 2 + (x ** 4) / (4 * 3 * 2)
end

# Hermite (エルミート) 補間
def hermite(d, z, a)
    sum = a[0]
    (1..Nx2).each do |i|
        prod = a[i]
        (0..(i - 1)).each do |j|
            if j != i
                prod *= (d - z[j])
			end
		end
        sum += prod
	end
    sum
end

x  = Array.new(N)
y  = Array.new(N)
yd = Array.new(N)

# 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
(0..N).each do |i|
    d = i * 1.5 - 4.5
    x[i]  = d
    y[i]  = f(d)
    yd[i] = fd(d)
end

# 差分商の表を作る
z = Array.new(Nx2)
d = Array.new(Nx2+1) { Array.new(Nx2) }
(0..Nx2).each do |i|
    j = i / 2
    z[i]    = x[j]
    d[0][i] = y[j]
end

(1..Nx2).each do |i|
	(0..(Nx2-i)).each do |j|
        if i == 1 && j % 2 == 0
            d[i][j] = yd[j / 2]
        else
        	d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (z[j+i] - z[j])
		end
	end
end

# ｎ階差分商
a = Array.new(Nx2)
(0..Nx2).each do |j|
    a[j] = d[j][0]
end

# 0.5刻みで 与えられていない値を補間 
(0..18).each do |i|
    d1 = i * 0.5 - 4.5
    d2 = f(d1)
    d3 = hermite(d1, z, a)

    # 元の関数と比較
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d1, d2, d3, d2 - d3)
end
