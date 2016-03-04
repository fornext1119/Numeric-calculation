N = 3

def a = [[ 9.0,  2.0, 1.0,  1.0], [2.0, 8.0, -2.0, 1.0], [-1.0, -2.0, 7.0, -2.0], [1.0, -1.0, -2.0, 6.0]]  as double[][]
def b =  [20.0, 16.0, 8.0, 17.0] as double[]
def c =  [ 0.0,  0.0, 0.0,  0.0] as double[]

// �s�{�b�g�I��
pivoting(a,b)

println("pivoting")
println("A")
disp_matrix(a)
println("B")
disp_vector(b)
println()

// �O�i����
forward_elimination(a,b)

println("forward elimination")
println("A")
disp_matrix(a)
println("B")
disp_vector(b)
println()

// ��ޑ��
backward_substitution(a,b)

println("X")
disp_vector(b)

// �O�i����
def forward_elimination(a, b) {
  	for (pivot in 0..(N - 1)) {
        for (row in (pivot + 1)..N) {
            s = a[row][pivot] / a[pivot][pivot]
            for (col in pivot..N)
                a[row][col] -= a[pivot][col] * s
            b[row]          -= b[pivot]      * s
        }
    }
}
// ��ޑ��
def backward_substitution(a, b) {
    for (row = N; row >= 0; row--) {
        for (col = N; col > row; col--)
            b[row] -= a[row][col] * b[col]
        b[row] /= a[row][row]
    }
}
// �s�{�b�g�I��
def pivoting(a, b) {
    for (pivot in 0..N) {
        // �e��� ��Ԓl���傫���s�� �T��
        max_row =   pivot
        max_val =   0
        for (row in pivot..N) {
            if (Math.abs(a[row][pivot]) > max_val) {
                // ��Ԓl���傫���s
                max_val =   Math.abs(a[row][pivot])
                max_row =   row
            }
        }

        // ��Ԓl���傫���s�Ɠ���ւ�
        if (max_row != pivot) {
            tmp = 0
            for (col in 0..N) {
                tmp             =   a[max_row][col]
                a[max_row][col] =   a[pivot][col]
                a[pivot][col]   =   tmp
            }
            tmp        =   b[max_row]
            b[max_row] =   b[pivot]
            b[pivot]   =   tmp
        }
    }
}
// �P�����z���\��
def disp_matrix(matrix) {
    for (row in matrix) {
        for (col in row) {
            printf ("%14.10f\t" , col)
        }
        println()
    }
}
// �Q�����z���\��
def disp_vector(row) {
    for (col in row) {
        printf ("%14.10f\t" , col)
    }
    println()
}
