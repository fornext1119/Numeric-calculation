# coding: Shift_JIS

N = 3

# １次元配列を表示
def disp_vector(row)
    row.each do |col|
        printf("%14.10f\t", col)
    end
    puts ""
end

# ２次元配列を表示
def disp_matrix(matrix)
    matrix.each do |row|
        row.each do |col|
            printf("%14.10f\t", col)
        end
        puts ""
    end
end

# ハウスホルダー変換
def tridiagonalize(a, d, e)
    v =  [0.0 ,0.0 ,0.0 ,0.0]

    (0..(N - 2)).each do |k|
        w = [0.0 ,0.0 ,0.0 ,0.0]
        d[k] = a[k][k]

        t = 0.0
        ((k + 1)..N).each do |i|
            w[i] =  a[i][k]
            t    += w[i] * w[i]
        end
        s = Math.sqrt(t)
        s = -s if (w[k + 1] < 0)

        if (s.abs < 0.00000000001)
            e[k + 1] = 0.0
        else
            e[k + 1]  = -s
            w[k + 1] +=  s
            s = 1 / Math.sqrt(w[k + 1] * s)
            ((k + 1)..N).each do |i|
                w[i] *= s
            end

            ((k + 1)..N).each do |i|
                s = 0.0
                ((k + 1)..N).each do |j|
                    if (j <= i)
                        s += a[i][j] * w[j]
                    else
                        s += a[j][i] * w[j]
                    end
				end
                v[i] = s
            end

            s = 0.0
            ((k + 1)..N).each do |i|
                s += w[i] * v[i]
            end
            s /= 2.0
            ((k + 1)..N).each do |i|
                v[i] -= s * w[i]
            end
            ((k + 1)..N).each do |i|
                ((k + 1)..i).each do |j|
                    a[i][j] -= w[i] * v[j] + w[j] * v[i]
                end
            end
            # 次の行は固有ベクトルを求めないなら不要
            ((k + 1)..N).each do |i|
                a[i][k] = w[i]
            end
        end
    end

    d[N - 1] = a[N - 1][N - 1]
    d[N]     = a[N][N]

    e[0]     = 0.0
    e[N]     = a[N][N - 1]

    # 次の行は固有ベクトルを求めないなら不要
    (0..N).reverse_each do |k|
        w = [0.0 ,0.0 ,0.0 ,0.0]
        if (k < N - 1)
            ((k + 1)..N).each do |i|
                w[i] = a[i][k]
            end
            ((k + 1)..N).each do |i|
                s = 0.0
                ((k + 1)..N).each do |j|
                    s += a[i][j] * w[j]
                end
                v[i] = s
            end
            ((k + 1)..N).each do |i|
                ((k + 1)..N).each do |j|
                    a[i][j] -= v[i] * w[j]
                end
            end
        end

        (0..N).each do |i|
            a[i][k] = 0.0
        end
        a[k][k] = 1.0
    end
end

# QR分解
def decomp(a, d, e)
    e[0] = 1.0
    h = N - 1
    h -= 1 while ((e[h]).abs < 0.00000000001)

    while (h > 0)
        e[0] = 0.0
        l = h - 1
        l -= 1 while ((e[l]).abs >= 0.00000000001)

        (1..100).each do |j|
            w = (d[h - 1] - d[h]) / 2.0
            s = Math.sqrt(w * w + e[h] * e[h])
            s = -s if (w < 0.0)

            x = d[l] - d[h] + e[h] * e[h] / (w + s)
            y = e[l + 1]
            z = 0.0
            t = 0.0
            u = 0.0
            (l..(h - 1)).each do |k|
                if (x.abs >= y.abs)
                    t = -y / x
                    u = 1 / Math.sqrt(t * t + 1.0)
                    s = t * u
                else
                    t = -x / y
                    s = 1 / Math.sqrt(t * t + 1.0)
                    s = -s if (t < 0)
                    u = t * s
                end

                w = d[k] - d[k + 1]
                t = (w * s + 2 * u * e[k + 1]) * s
                d[k    ] = d[k    ] - t
                d[k + 1] = d[k + 1] + t
                e[k    ] = u * e[k] - s * z
                e[k + 1] = e[k + 1] * (u * u - s * s) + w * s * u

                # 次の行は固有ベクトルを求めないなら不要
                (0..N).each do |i|
                    x = a[k    ][i]
                    y = a[k + 1][i]
                    a[k    ][i] = u * x - s * y
                    a[k + 1][i] = s * x + u * y
                end

                if (k < N - 1)
                    x = e[k + 1]
                    y = -s * e[k + 2]
                    z = y
                    e[k + 2] = u * e[k + 2]
                end
            end
            printf("%3d\t", j)
            disp_vector(d)

            # 収束判定
            break if ((e[h]).abs < 0.00000000001)
        end                

        e[0] = 1.0
        h -= 1 while ((e[h]).abs < 0.00000000001)
    end            

    # 次の行は固有ベクトルを求めないなら不要
    (0..(N - 1)).each do |k|
        l = k
        ((k + 1)..N).each do |i|
            l = i if (d[i] > d[l])
        end

        t = d[k]
        d[k] = d[l]
        d[l] = t

        (0..N).each do |i|
            t       = a[k][i]
            a[k][i] = a[l][i]
            a[l][i] = t
        end
    end
end

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

puts ""
puts "eigenvalue"
disp_vector(d)

puts ""
puts "eigenvector"
disp_matrix(a)
