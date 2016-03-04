N = 3

def a = [[5.0,2.0,3.0,4.0],[2.0,10.0,6.0,7.0],[3.0,6.0,15.0,9.0],[4.0,7.0,9.0,20.0]]  as double[][]
def b =  [34.0,68.0,96.0,125.0] as double[]

println("A")
disp_matrix(a)
println("B")
disp_vector(b)
println()

// �O�i����
forward_elimination(a,b)

println("LDL^T")
disp_matrix(a)
println()

// Ly=b ���� y �����߂� (�O�i���)
y = [0.0,0.0,0.0,0.0]
forward_substitution(a,b,y)

println "Y"
disp_vector(y)

// DL^Tx=y ���� x �����߂� (��ޑ��)
x =  [0.0,0.0,0.0,0.0]
backward_substitution(a,y,x)

println("X")
disp_vector(x)

// �O�i����
def forward_elimination(a, b) {
    for (pivot in 0..N) {
        // pivot < k �̏ꍇ
        s = 0
        if (pivot > 0)
	        for (col in 0..(pivot-1)) {
	            s = a[pivot][col]
				if (col > 0)
		            for (k in 0..(col-1))
		                s -= a[pivot][k] * a[col][k] * a[k][k]
	            a[pivot][col] = s / a[col][col]
	            a[col][pivot] = a[pivot][col]
	        }

        // pivot == k �̏ꍇ
        s = a[pivot][pivot]
        if (pivot > 0)
	        for (k in 0..(pivot-1))
	            s -= a[pivot][k] * a[pivot][k] * a[k][k]
        a[pivot][pivot] = s
    }
}
// �O�i���
def forward_substitution(a, b, y) {
    for (row in 0..N) {
        for (col in 0..row)
            b[row] -= a[row][col] * y[col]
        y[row] = b[row]
    }
}
// ��ޑ��
def backward_substitution(a, y, x) {
    for (row = N; row >= 0; row--) {
        for (col = N; col > row; col--)
            y[row] -= a[row][col] * a[row][row] * x[col]
        x[row] = y[row] / a[row][row]
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
