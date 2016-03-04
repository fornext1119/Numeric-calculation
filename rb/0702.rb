# データ点の数 - 1
N = 6

# 元の関数
def f(x)
    x - (x ** 3) / (3 * 2) + (x ** 5) / (5 * 4 * 3 * 2)
end

# Neville (ネヴィル) 補間
def neville(d, x, y)
    w = Array.new(N+1) { Array.new(N) }
    (0..N).each do |i|
        w[0][i] = y[i]
    end

    (1..N).each do |j|
        (0..(N - j)).each do |i|
            w[j][i] = w[j-1][i+1] + (w[j-1][i+1] - w[j-1][i]) * (d - x[i+j]) / (x[i+j] - x[i])
        end
    end

    w[N][0]
end

x = Array.new(N)
y = Array.new(N)

# 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
(0..N).each do |i|
    d = i * 1.5 - 4.5
    x[i] = d
    y[i] = f(d)
end

# 0.5刻みで 与えられていない値を補間 
(0..18).each do |i|
    d  = i * 0.5 - 4.5
    d1 = f(d)
    d2 = neville(d, x, y)

    # 元の関数と比較
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d, d1, d2, d1 - d2)
end
