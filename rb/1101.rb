# coding: Shift_JIS

N = 3

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

# �x�L��@
def power(a, x0)
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

        # �s��̐� x1 = A �~ x0
        x1 =  [ 0.0,  0.0,  0.0,  0.0]
        (0..N).each do |i|
            (0..N).each do |j|
                x1[i] += a[i][j] * x0[j]
            end
        end

        # ����
        p0 = 0.0
        p1 = 0.0
        (0..N).each do |i|
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        end
        # �ŗL�l
        lambda = p0 / p1

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

# �x�L��@�ōő�ŗL�l�����߂�

a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
x =  [1.0 ,0.0 ,0.0 ,0.0]

# �x�L��@
lambda0 = power(a, x)

puts ""
puts "eigenvalue"
printf("%14.10f\n", lambda0)

puts "eigenvector"
disp_vector(x)
