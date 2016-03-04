# coding: Shift_JIS

N = 3

# 前進消去
def forward_elimination(a)
    0.upto(N - 1) do |pivot|
        (pivot + 1).upto(N) do |row|
            s = a[row][pivot] / a[pivot][pivot]
            pivot.upto(N) do |col|
                a[row][col] -= a[pivot][col] * s # これが 上三角行列
            end
            a[row][pivot]    = s                 # これが 下三角行列
        end
    end
end
# 前進代入
def forward_substitution(a, y, b)
    (0..N).each do |row|
        (0..row).each do |col|
            b[row] -= a[row][col] * y[col]
        end
        y[row] = b[row]
    end
end
# 後退代入
def backward_substitution(a, x, y)
    (0..N).reverse_each do |row|
        ((row + 1)..N).reverse_each do |col|
            y[row] -= a[row][col] * x[col]
        end
        x[row] = y[row] / a[row][row]
    end
end

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

# 逆ベキ乗法
def inverse(a, x0)
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

        # Ly=b から y を求める (前進代入)
        y = [0.0, 0.0, 0.0, 0.0]
        b = [0.0, 0.0, 0.0, 0.0]
        (0..N).each do |i|
            b[i] = x0[i]
        end
        forward_substitution(a, y, b)

        # Ux=y から x を求める (後退代入)
        x1 =  [ 0.0,  0.0,  0.0,  0.0]
        backward_substitution(a, x1, y)

        # 内積
        p0 = 0.0
        p1 = 0.0
        (0..N).each do |i|
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        end
        # 固有値
        lambda = p1 / p0

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

puts ""
puts "eigenvalue"
printf("%14.10f\n", lambda0)

puts "eigenvector"
disp_vector(x)
