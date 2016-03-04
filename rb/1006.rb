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
    0.upto(N) do |pivot|
        s = 0
        0.upto(pivot-1) do |col|
            s += a[pivot][col] * a[pivot][col]
        end
        # �����ō����̒������̒l�ɂȂ�ƌv�Z�ł��Ȃ��I
        a[pivot][pivot] = Math.sqrt(a[pivot][pivot] - s)

        (pivot + 1).upto(N) do |row|
            s = 0
            0.upto(pivot-1) do |col|
                s += a[row][col] * a[pivot][col]
            end
            a[row][pivot] = (a[row][pivot] - s) / a[pivot][pivot]
            a[pivot][row] = a[row][pivot]
        end
    end
end
# �O�i���
def forward_substitution(a, b, y)
    (0..N).each do |row|
        (0..row).each do |col|
            b[row] -= a[row][col] * y[col]
        end
        y[row] = b[row] / a[row][row]
    end
end
# ��ޑ��
def backward_substitution(a, y, x)
    N.downto(0) do |row|
        N.downto(row + 1) do |col|
            y[row] -= a[row][col] * x[col]
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

puts "LL^T"
disp_matrix(a)

# Ly=b ���� y �����߂� (�O�i���)
y = [0.0,0.0,0.0,0.0]
forward_substitution(a,b,y)

puts "Y"
disp_vector(y)

# L^Tx=y ���� x �����߂� (��ޑ��)
x =  [0.0,0.0,0.0,0.0]
backward_substitution(a,y,x)

puts "X"
disp_vector(x)
