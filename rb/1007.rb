# coding: Shift_JIS

N = 3

# �Q�����z���\��
def disp_matrix(matrix)
    matrix.each do |row|
      	row.each do |col|
        	printf("%14.10f\t", col)
      	end
      	puts ""
    end
end
# �P�����z���\��
def disp_vector(row)
  	row.each do |col|
    	printf("%14.10f\t", col)
  	end
  	puts ""
end
# �O�i����
def forward_elimination(a, b)
    (0..N).each do |pivot|
        # pivot < k �̏ꍇ
        s = 0
        (0..(pivot-1)).each do |col|
            s = a[pivot][col]
            (0..(col-1)).each do |k|
                s -= a[pivot][k] * a[col][k] * a[k][k]
            end
            a[pivot][col] = s / a[col][col]
            a[col][pivot] = a[pivot][col]
        end

        # pivot == k �̏ꍇ
        s = a[pivot][pivot]
        (0..(pivot-1)).each do |k|
            s -= a[pivot][k] * a[pivot][k] * a[k][k]
        end
        a[pivot][pivot] = s
    end
end
# �O�i���
def forward_substitution(a, b, y)
    (0..N).each do |row|
        (0..row).each do |col|
            b[row] -= a[row][col] * y[col]
        end
        y[row] = b[row]
    end
end
# ��ޑ��
def backward_substitution(a, y, x)
    N.downto(0) do |row|
        N.downto(row + 1) do |col|
            y[row] -= a[row][col] * a[row][row] * x[col]
        end
        x[row] = y[row] / a[row][row]
    end
end

a = [[5.0,2.0,3.0,4.0],[2.0,10.0,6.0,7.0],[3.0,6.0,15.0,9.0],[4.0,7.0,9.0,20.0]]
b =  [34.0,68.0,96.0,125.0]

puts "A"
disp_matrix(a)
puts "B"
disp_vector(b)
puts ""

# �O�i����
forward_elimination(a,b)

puts "LDL^T"
disp_matrix(a)

# Ly=b ���� y �����߂� (�O�i���)
y = [0.0,0.0,0.0,0.0]
forward_substitution(a,b,y)

puts "Y"
disp_vector(y)

# DL^Tx=y ���� x �����߂� (��ޑ��)
x =  [0.0,0.0,0.0,0.0]
backward_substitution(a,y,x)

puts "X"
disp_vector(x)
