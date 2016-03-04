# coding: Shift_JIS

N = 3

# １次元配列を表示
def disp_matrix(matrix)
    matrix.each do |row|
      	row.each do |col|
        	printf("%14.10f\t", col)
      	end
      	puts ""
    end
end
# ２次元配列を表示
def disp_vector(row)
  	row.each do |col|
    	printf("%14.10f\t", col)
  	end
  	puts ""
end
# 前進消去
def forward_elimination(a, b)
  	0.upto(N - 1) do |pivot|
        (pivot + 1).upto(N) do |row|
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
    N.downto(0) do |row|
        N.downto(row + 1) do |col|
            b[row] -= a[row][col] * b[col]
        end
        b[row] /= a[row][row]
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
