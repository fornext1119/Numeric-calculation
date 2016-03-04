# coding: Shift_JIS

N = 3

# �O�i����
def forward_elimination(a)
    0.upto(N - 1) do |pivot|
        (pivot + 1).upto(N) do |row|
            s = a[row][pivot] / a[pivot][pivot]
            pivot.upto(N) do |col|
                a[row][col] -= a[pivot][col] * s # ���ꂪ ��O�p�s��
            end
            a[row][pivot]    = s                 # ���ꂪ ���O�p�s��
        end
    end
end
# �O�i���
def forward_substitution(a, y, b)
    (0..N).each do |row|
        (0..row).each do |col|
            b[row] -= a[row][col] * y[col]
        end
        y[row] = b[row]
    end
end
# ��ޑ��
def backward_substitution(a, x, y)
    (0..N).reverse_each do |row|
        ((row + 1)..N).reverse_each do |col|
            y[row] -= a[row][col] * x[col]
        end
        x[row] = y[row] / a[row][row]
    end
end

# �P�����z���\��
def disp_vector(row)
    row.each do |col|
        printf("%14.10f\t", col)
    end
    puts ""
end
# ���K�� (�x�N�g���̒������P�ɂ���)
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

# �t�x�L��@
def inverse(a, x0)
    lambda = 0.0

    # ���K�� (�x�N�g�� x0 �̒������P�ɂ���)
    normarize(x0)
    e0 = 0.0
    (0..N).each do |i|
        e0 += x0[i]
    end

    (1..200).each do |k|
        # �P�����z���\��
        printf("%3d\t", k)
        disp_vector(x0)

        # Ly=b ���� y �����߂� (�O�i���)
        y = [0.0, 0.0, 0.0, 0.0]
        b = [0.0, 0.0, 0.0, 0.0]
        (0..N).each do |i|
            b[i] = x0[i]
        end
        forward_substitution(a, y, b)

        # Ux=y ���� x �����߂� (��ޑ��)
        x1 =  [ 0.0,  0.0,  0.0,  0.0]
        backward_substitution(a, x1, y)

        # ����
        p0 = 0.0
        p1 = 0.0
        (0..N).each do |i|
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        end
        # �ŗL�l
        lambda = p1 / p0

        # ���K�� (�x�N�g�� x1 �̒������P�ɂ���)
        normarize(x1)
        # ��������
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

# �t�x�L��@�ōŏ��ŗL�l�����߂�

a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
x =  [1.0 ,0.0 ,0.0 ,0.0]

# LU����
forward_elimination(a)

# �t�x�L��@
lambda0 = inverse(a, x)

puts ""
puts "eigenvalue"
printf("%14.10f\n", lambda0)

puts "eigenvector"
disp_vector(x)
