# coding: Shift_JIS

N = 3

# �Ίp�v�f��\��
def disp_eigenvalue(a)
    (0..N).each do |i|
        printf("%14.10f\t", a[i][i])
    end
    puts ""
end

# �s��̐�
def multiply(a, b, c)
    (0..N).each do |i|
        (0..N).each do |j|
            s = 0.0
            (0..N).each do |k|
                s += a[i][k] * b[k][j]
            end
            c[i][j] = s
        end
    end
end

# QR����
def decomp(a, q, r)
    x = [0.0 ,0.0 ,0.0 ,0.0]

    (0..N).each do |k|
        (0..N).each do |i|
            x[i] = a[i][k]
		end
	
	    (0..(k - 1)).each do |j|
            t = 0.0
		    (0..N).each do |i|
                t += a[i][k] * q[i][j]
			end
            r[j][k] = t
            r[k][j] = 0.0
		    (0..N).each do |i|
                x[i] -= t * q[i][j]
			end
		end

        s = 0.0
	    (0..N).each do |i|
            s += x[i] * x[i]
		end
        r[k][k] = Math.sqrt(s)
	    (0..N).each do |i|
            q[i][k] = x[i] / r[k][k]
		end
	end
end

# QR�����ŌŗL�l�����߂�

a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
q = [[0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0]]
r = [[0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,0.0]]

(1..200).each do |k|
    # QR����
    decomp(a, q, r)
    # �s��̐�
    multiply(r, q, a)
    # �Ίp�v�f��\��
    printf("%3d\t", k)
    disp_eigenvalue(a)

    # ��������
    e = 0.0
    (1..N).each do |i|
        (0..(i - 1)).each do |j|
            e += (a[i][j]).abs
        end
    end
    break if (e < 0.00000000001)
end

puts ""
puts "eigenvalue"
disp_eigenvalue(a)
