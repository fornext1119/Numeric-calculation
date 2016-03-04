N = 3

// ���R�r�@�ŌŗL�l�����߂�
main()

def main() {
    def a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]] as double[][]
    def v = [[1.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,1.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,1.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,1.0]] as double[][]

    // ���R�r�@
    jacobi(a, v)

    println()
    println("eigenvalue")
    disp_eigenvalue(a)

    println()
    println("eigenvector")
    disp_eigenvector(v)
}

// ���R�r�@
def jacobi(a, v) {

    for (k in 1..200) {
        // �ő�l��T��
		p = 0
		q = 0
        max_val = 0.0
        for (i in 0..(N - 1)) {
            for (j in (i + 1)..N) {
                if (max_val < Math.abs(a[i][j])) {
                    max_val = Math.abs(a[i][j])
                    p = i
                    q = j
				}
			}
		}

        // �� �����߂�
        t = 0.0
        if (Math.abs(a[p][p] - a[q][q]) < 0.00000000001) {
            // a_{pp} �� a_{qq} �̂Ƃ��A��]�p������/4�ɂ���
            t = Math.PI / 4.0
			if (a[p][p] < 0)
				t = -t
        } else {
            // a_{pp} �� a_{qq} �̂Ƃ�
            t = Math.atan(2.0 * a[p][q] / (a[p][p] - a[q][q])) / 2.0
        }

        // �� ���g���� �s�� U ���쐬���AA = U^t �~ A �~ U
        c = Math.cos(t)
        s = Math.sin(t)
        // U^t �~ A
        t1 = 0.0
        t2 = 0.0
        for (i in 0..N) {
            t1      =  a[p][i] * c + a[q][i] * s
            t2      = -a[p][i] * s + a[q][i] * c
            a[p][i] = t1
            a[q][i] = t2
            // �ŗL�x�N�g��
            t1      =  v[p][i] * c + v[q][i] * s
            t2      = -v[p][i] * s + v[q][i] * c
            v[p][i] = t1
            v[q][i] = t2
        }
        // A �~ U
        for (i in 0..N) {
            t1      =  a[i][p] * c + a[i][q] * s
            t2      = -a[i][p] * s + a[i][q] * c
            a[i][p] = t1
            a[i][q] = t2
        }

        // �Ίp�v�f��\��
        printf("%3d\t" , k)
        disp_eigenvalue(a)

        // ��������
    	if (max_val < 0.00000000001) break
    }
}

// �Ίp�v�f��\��
def disp_eigenvalue(a) {
    for (i in 0..N)
        printf("%14.10f\t" , a[i][i])
    println()
}
// �ŗL�x�N�g����\��
def disp_eigenvector(matrix) {
    for (i in 0..N) {
		row = [0.0 ,0.0 ,0.0 ,0.0]
        for (j in 0..N)
            row[j] = matrix[i][j]
        normarize(row)
        disp_vector(row)
	}
}
// �P�����z���\��
def disp_vector(row) {
    for (col in row) {
        printf("%14.10f\t" , col)
    }
    println()
}
// ���K�� (�x�N�g���̒������P�ɂ���)
def normarize(x) {
    s = 0.0

    for (i in 0..N)
        s += x[i] * x[i]
    s = Math.sqrt(s)

    for (i in 0..N)
        x[i] /= s
}
