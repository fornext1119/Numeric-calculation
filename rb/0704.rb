# �f�[�^�_�̐� - 1
N   =  6
Nx2 = 13

# ���̊֐�
def f(x)
    x - (x ** 3) / (3 * 2) + (x ** 5) / (5 * 4 * 3 * 2)
end

# ���֐�
def fd(x)
    1 - (x ** 2) / 2 + (x ** 4) / (4 * 3 * 2)
end

# Hermite (�G���~�[�g) ���
def hermite(d, z, a)
    sum = a[0]
    (1..Nx2).each do |i|
        prod = a[i]
        (0..(i - 1)).each do |j|
            if j != i
                prod *= (d - z[j])
			end
		end
        sum += prod
	end
    sum
end

x  = Array.new(N)
y  = Array.new(N)
yd = Array.new(N)

# 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
(0..N).each do |i|
    d = i * 1.5 - 4.5
    x[i]  = d
    y[i]  = f(d)
    yd[i] = fd(d)
end

# �������̕\�����
z = Array.new(Nx2)
d = Array.new(Nx2+1) { Array.new(Nx2) }
(0..Nx2).each do |i|
    j = i / 2
    z[i]    = x[j]
    d[0][i] = y[j]
end

(1..Nx2).each do |i|
	(0..(Nx2-i)).each do |j|
        if i == 1 && j % 2 == 0
            d[i][j] = yd[j / 2]
        else
        	d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (z[j+i] - z[j])
		end
	end
end

# ���K������
a = Array.new(Nx2)
(0..Nx2).each do |j|
    a[j] = d[j][0]
end

# 0.5���݂� �^�����Ă��Ȃ��l���� 
(0..18).each do |i|
    d1 = i * 0.5 - 4.5
    d2 = f(d1)
    d3 = hermite(d1, z, a)

    # ���̊֐��Ɣ�r
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d1, d2, d3, d2 - d3)
end
