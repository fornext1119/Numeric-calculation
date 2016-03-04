# coding: Shift_JIS

N = 3

# 対角要素を表示
def disp_eigenvalue(a)
    (0..N).each do |i|
        printf("%14.10f\t", a[i][i])
    end
    puts ""
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

# 固有ベクトルを表示
def disp_eigenvector(matrix)
    (0..N).each do |i|
        row = [0.0 ,0.0 ,0.0 ,0.0]
    	(0..N).each do |j|
            row[j] = matrix[i][j]
		end
        normarize(row)
        disp_vector(row)
	end
end

# ヤコビ法
def jacobi(a, v)
    (1..200).each do |k|
        # 最大値を探す
        p = 0
        q = 0
        max_val = 0.0
	    (0..N).each do |i|
		    ((i + 1)..N).each do |j|
                if (max_val < (a[i][j]).abs)
                    max_val = (a[i][j]).abs
                    p = i
                    q = j
				end
			end
		end

        # θ を求める
        t = 0.0
        if ((a[p][p] - a[q][q]).abs < 0.00000000001)
            # a_{pp} ＝ a_{qq} のとき、回転角ｔをπ/4にする
            t = Math::PI / 4.0
            t = -t if (a[p][p] < 0)
        else
            # a_{pp} ≠ a_{qq} のとき
            t = Math.atan(2.0 * a[p][q] / (a[p][p] - a[q][q])) / 2.0
        end

        # θ を使って 行列 U を作成し、A = U^t × A × U
        c = Math.cos(t)
        s = Math.sin(t)
        # U^t × A
        t1 = 0.0
        t2 = 0.0
	    (0..N).each do |i|
            t1      =  a[p][i] * c + a[q][i] * s
            t2      = -a[p][i] * s + a[q][i] * c
            a[p][i] = t1
            a[q][i] = t2
            # 固有ベクトル
            t1      =  v[p][i] * c + v[q][i] * s
            t2      = -v[p][i] * s + v[q][i] * c
            v[p][i] = t1
            v[q][i] = t2
		end
        # A × U
	    (0..N).each do |i|
            t1      =  a[i][p] * c + a[i][q] * s
            t2      = -a[i][p] * s + a[i][q] * c
            a[i][p] = t1
            a[i][q] = t2
		end

        # 対角要素を表示
        printf("%3d\t", k)
        disp_eigenvalue(a)

        # 収束判定
        break if (max_val < 0.00000000001)
	end
end            

# ヤコビ法で固有値を求める
a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
v = [[1.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,1.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,1.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,1.0]]

# ヤコビ法
jacobi(a, v)

puts ""
puts "eigenvalue"
disp_eigenvalue(a)

puts ""
puts "eigenvector"
disp_eigenvector(v)
