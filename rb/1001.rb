# coding: Shift_JIS

N = 3

# １次元配列を表示
def disp_vector(row)
  	row.each do |col|
    	printf("%14.10f\t", col)
  	end
  	puts ""
end

# ヤコビの反復法
def jacobi(a, b, x0)
    while true
        x1 = []
        finish = true
        (0..N).each do |i|
            x1[i] = 0
            (0..N).each do |j|
                if (j != i)
                    x1[i] += a[i][j] * x0[j]
                end
            end
            x1[i] = (b[i] - x1[i]) / a[i][i]
            if ((x1[i] - x0[i]).abs > 0.0000000001)
                finish = false
            end
        end
        (0..N).each do |i|
            x0[i] = x1[i]
        end

        return if finish

        disp_vector(x0)
    end
end

a = [[ 9.0,  2.0, 1.0,  1.0], [2.0, 8.0, -2.0, 1.0], [-1.0, -2.0, 7.0, -2.0], [1.0, -1.0, -2.0, 6.0]]
b =  [20.0, 16.0, 8.0, 17.0]
c =  [ 0.0,  0.0, 0.0,  0.0]

# ヤコビの反復法
jacobi(a,b,c)

puts "X"
disp_vector(c)
