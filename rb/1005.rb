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
    0.upto(N - 1) do |pivot|
        (pivot + 1).upto(N) do |row|
            s = a[row][pivot] / a[pivot][pivot]
            pivot.upto(N) do |col|
                a[row][col] -= a[pivot][col] * s # ���ꂪ ��O�p�s��
            end
            a[row][pivot]    = s                 # ���ꂪ ���O�p�s��
            # b[row]        -= b[pivot]      * s # ���̒l�͕ύX���Ȃ�
        end
    end
end
# Ly=b ���� y �����߂� (�O�i���)
def forward_substitution(a, b, y)
    (0..N).each do |row|
        (0..row).each do |col|
            b[row] -= a[row][col] * y[col]
        end
        y[row] = b[row]
    end
end
# Ux=y ���� x �����߂� (��ޑ��)
def backward_substitution(a, y, x)
    N.downto(0) do |row|
        N.downto(row + 1) do |col|
            y[row] -= a[row][col] * x[col]
        end
        x[row] = y[row] / a[row][row]
    end
end
# �s�{�b�g�I��
def pivoting(a, b)
    (0..N).each do |pivot|
        # �e��� ��Ԓl���傫���s�� �T��
        max_row =   pivot
        max_val =   0
        (pivot..N).each do |row|
            if ((a[row][pivot]).abs > max_val)
                # ��Ԓl���傫���s
                max_val =   (a[row][pivot]).abs
                max_row =   row
            end
        end

        # ��Ԓl���傫���s�Ɠ���ւ�
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

# �s�{�b�g�I��
pivoting(a,b)

puts "pivoting"
puts "A"
disp_matrix(a)
puts "B"
disp_vector(b)
puts ""

# �O�i����
forward_elimination(a,b)

puts "LU"
disp_matrix(a)

# Ly=b ���� y �����߂� (�O�i���)
y = [0.0,0.0,0.0,0.0]
forward_substitution(a,b,y)

puts "Y"
disp_vector(y)

# Ux=y ���� x �����߂� (��ޑ��)
x =  [0.0,0.0,0.0,0.0]
backward_substitution(a,y,x)

puts "X"
disp_vector(x)
