# coding: Shift_JIS

N = 3

# ２次元配列を表示
def disp_matrix(matrix)
    matrix.each do |row|
      	row.each do |col|
        	printf("%14.10f\t", col)
      	end
      	puts ""
    end
end
# １次元配列を表示
def disp_vector(row)
  	row.each do |col|
    	printf("%14.10f\t", col)
  	end
  	puts ""
end
# 前進消去
def forward_elimination(a, b)
    0.upto(N) do |pivot|
        0.upto(N) do |row|
            next if (row == pivot)

            s = a[row][pivot] / a[pivot][pivot]
            pivot.upto(N) do |col|
                a[row][col] -= a[pivot][col] * s
            end
            b[row]          -= b[pivot]      * s
        end
    end
end
# 後退代入
def backward_substitution(a, b)
    0.upto(N) do |pivot|
        b[pivot] /= a[pivot][pivot]
    end
end
# ピボット選択
def pivoting(a, b)
    (0..N).each do |pivot|
        # 各列で 一番値が大きい行を 探す
        max_row =   pivot
        max_val =   0
        (pivot..N).each do |row|
            if ((a[row][pivot]).abs > max_val)
                # 一番値が大きい行
                max_val =   (a[row][pivot]).abs
                max_row =   row
            end
        end

        # 一番値が大きい行と入れ替え
        if (max_row != pivot)
            tmp = 0
            (0..N).each do |col|
                tmp             =   a[max_row][col]
                a[max_row][col] =   a[pivot][col]
                a[pivot][col]   =   tmp
            end
            tmp        =   b[max_row]
            b[max_row] =   b[pivot]
            b[pivot]   =   tmp
        end
    end
end
# 状態を確認
def disp_progress(a, b)
    (0..N).each do |i|
        (0..N).each do |j|
            printf("%14.10f\t", a[i][j])
        end
        printf("%14.10f\n", b[i])
    end
    puts ""
end

a = [[-1.0,-2.0,7.0,-2.0],[1.0,-1.0,-2.0,6.0],[9.0,2.0,1.0,1.0],[2.0,8.0,-2.0,1.0]]
b =  [8.0,17.0,20.0,16.0]

# ピボット選択
pivoting(a,b)

puts "pivoting"
puts "A"
disp_matrix(a)
puts "B"
disp_vector(b)
puts ""

# 前進消去
forward_elimination(a,b)

puts "forward elimination"
puts "A"
disp_matrix(a)
puts "B"
disp_vector(b)
puts ""

# 後退代入
backward_substitution(a,b)

puts "X"
disp_vector(b)
