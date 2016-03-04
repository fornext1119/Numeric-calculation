# �f�[�^�_�̐� - 1
N = 6

# ���̊֐�
def f(x)
    x - (x ** 3) / (3 * 2) + (x ** 5) / (5 * 4 * 3 * 2)
end

# Newton (�j���[�g��) ���
def newton(d, x, a)
    sum = a[0]
    (1..N).each do |i|
        prod = a[i]
        (0..(i - 1)).each do |j|
            if j != i
                prod *= (d - x[j])
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

# �������̕\�����
d = Array.new(N+1) { Array.new(N) }
(0..N).each do |j|
    d[0][j] = y[j]
end

(1..N).each do |i|
	(0..(N-i)).each do |j|
        d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (x[j+i] - x[j])
	end
end

# ���K������
a = Array.new(N)
(0..N).each do |j|
    a[j] = d[j][0]
end

# 0.5���݂� �^�����Ă��Ȃ��l���� 
(0..18).each do |i|
    d1 = i * 0.5 - 4.5
    d2 = f(d1)
    d3 = newton(d1, x, a)

    # ���̊֐��Ɣ�r
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d1, d2, d3, d2 - d3)
end
