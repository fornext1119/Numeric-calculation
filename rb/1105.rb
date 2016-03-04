# coding: Shift_JIS

N = 3

# �Ίp�v�f��\��
def disp_eigenvalue(a)
    (0..N).each do |i|
        printf("%14.10f\t", a[i][i])
    end
    puts ""
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

# �ŗL�x�N�g����\��
def disp_eigenvector(matrix)
    (0..N).each do |i|
        row = [0.0 ,0.0 ,0.0 ,0.0]
    	(0..N).each do |j|
            row[j] = matrix[i][j]
		end
        normarize(row)
        disp_vector(row)
	end
end

# ���R�r�@
def jacobi(a, v)
    (1..200).each do |k|
        # �ő�l��T��
        p = 0
        q = 0
        max_val = 0.0
	    (0..N).each do |i|
		    ((i + 1)..N).each do |j|
                if (max_val < (a[i][j]).abs)
                    max_val = (a[i][j]).abs
                    p = i
                    q = j
				end
			end
		end

        # �� �����߂�
        t = 0.0
        if ((a[p][p] - a[q][q]).abs < 0.00000000001)
            # a_{pp} �� a_{qq} �̂Ƃ��A��]�p������/4�ɂ���
            t = Math::PI / 4.0
            t = -t if (a[p][p] < 0)
        else
            # a_{pp} �� a_{qq} �̂Ƃ�
            t = Math.atan(2.0 * a[p][q] / (a[p][p] - a[q][q])) / 2.0
        end

        # �� ���g���� �s�� U ���쐬���AA = U^t �~ A �~ U
        c = Math.cos(t)
        s = Math.sin(t)
        # U^t �~ A
        t1 = 0.0
        t2 = 0.0
	    (0..N).each do |i|
            t1      =  a[p][i] * c + a[q][i] * s
            t2      = -a[p][i] * s + a[q][i] * c
            a[p][i] = t1
            a[q][i] = t2
            # �ŗL�x�N�g��
            t1      =  v[p][i] * c + v[q][i] * s
            t2      = -v[p][i] * s + v[q][i] * c
            v[p][i] = t1
            v[q][i] = t2
		end
        # A �~ U
	    (0..N).each do |i|
            t1      =  a[i][p] * c + a[i][q] * s
            t2      = -a[i][p] * s + a[i][q] * c
            a[i][p] = t1
            a[i][q] = t2
		end

        # �Ίp�v�f��\��
        printf("%3d\t", k)
        disp_eigenvalue(a)

        # ��������
        break if (max_val < 0.00000000001)
	end
end            

# ���R�r�@�ŌŗL�l�����߂�
a = [[5.0, 4.0, 1.0, 1.0],
     [4.0, 5.0, 1.0, 1.0],
     [1.0, 1.0, 4.0, 2.0],
     [1.0, 1.0, 2.0, 4.0]]
v = [[1.0 ,0.0 ,0.0 ,0.0],
     [0.0 ,1.0 ,0.0 ,0.0],
     [0.0 ,0.0 ,1.0 ,0.0],
     [0.0 ,0.0 ,0.0 ,1.0]]

# ���R�r�@
jacobi(a, v)

puts ""
puts "eigenvalue"
disp_eigenvalue(a)

puts ""
puts "eigenvector"
disp_eigenvector(v)
