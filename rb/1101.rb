# coding: Shift_JIS

N = 3

# １次元配列を表示
def disp_vector(row)
    row.each do |col|
        printf("%14.10f\t", col)
    end
    puts ""
end
# 正規化 (ベクトルの長さを１にする)
def normarize(x)
    s = 0.0

    (0..N).each do |i|
        s += x[i] * x[i]
    end
    s = Math.sqrt(s)

    (0..N).each do |i|
        x[i] /= s
    end
end

# ベキ乗法
def power(a, x0)
    lambda = 0.0

    # 正規化 (ベクトル x0 の長さを１にする)
    normarize(x0)
    e0 = 0.0
    (0..N).each do |i|
        e0 += x0[i]
    end

    (1..200).each do |k|
        # １次元配列を表示
        printf("%3d\t", k)
        disp_vector(x0)

        # 行列の積 x1 = A × x0
        x1 =  [ 0.0,  0.0,  0.0,  0.0]
        (0..N).each do |i|
            (0..N).each do |j|
                x1[i] += a[i][j] * x0[j]
            end
        end

        # 内積
        p0 = 0.0
        p1 = 0.0
        (0..N).each do |i|
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        end
        # 固有値
        lambda = p0 / p1

        # 正規化 (ベクトル x1 の長さを１にする)
        normarize(x1)
        # 収束判定
        e1 = 0.0
        (0..N).each do |i|
            e1 += x1[i]
        end
        break if ((e0 - e1).abs < 0.00000000001)

        (0..N).each do |i|
            x0[i] = x1[i]
        end
        e0 = e1
    end

    lambda
end

# ベキ乗法で最大固有値を求める

a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
x =  [1.0 ,0.0 ,0.0 ,0.0]

# ベキ乗法
lambda0 = power(a, x)

puts ""
puts "eigenvalue"
printf("%14.10f\n", lambda0)

puts "eigenvector"
disp_vector(x)
