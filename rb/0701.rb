# �f�[�^�_�̐� - 1
N = 6

# ���̊֐�
def f(x)
    x - (x ** 3) / (3 * 2) + (x ** 5) / (5 * 4 * 3 * 2)
end

# Lagrange (���O�����W��) ���
def lagrange(d, x, y)
    sum = 0
    (0..N).each do |i|
        prod = y[i]
        (0..N).each do |j|
            if j != i
                prod *= (d - x[j]) / (x[i] - x[j])
			end
		end
        sum += prod
	end
    sum
end

x = Array.new(N)
y = Array.new(N)

# 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
(0..N).each do |i|
    d = i * 1.5 - 4.5
    x[i] = d
    y[i] = f(d)
end

# 0.5���݂� �^�����Ă��Ȃ��l���� 
(0..18).each do |i|
    d  = i * 0.5 - 4.5
    d1 = f(d)
    d2 = lagrange(d, x, y)

    # ���̊֐��Ɣ�r
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d, d1, d2, d1 - d2)
end
