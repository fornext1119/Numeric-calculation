N = 3

def a = [[5.0,2.0,3.0,4.0],[2.0,10.0,6.0,7.0],[3.0,6.0,15.0,9.0],[4.0,7.0,9.0,20.0]]  as double[][]
def b =  [34.0,68.0,96.0,125.0] as double[]

println("A")
disp_matrix(a)
println("B")
disp_vector(b)
println()

// 前進消去
forward_elimination(a,b)

println("LDL^T")
disp_matrix(a)
println()

// Ly=b から y を求める (前進代入)
y = [0.0,0.0,0.0,0.0]
forward_substitution(a,b,y)

println "Y"
disp_vector(y)

// DL^Tx=y から x を求める (後退代入)
x =  [0.0,0.0,0.0,0.0]
backward_substitution(a,y,x)

println("X")
disp_vector(x)

// 前進消去
def forward_elimination(a, b) {
    for (pivot in 0..N) {
        // pivot < k の場合
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

        // pivot == k の場合
        s = a[pivot][pivot]
        if (pivot > 0)
	        for (k in 0..(pivot-1))
	            s -= a[pivot][k] * a[pivot][k] * a[k][k]
        a[pivot][pivot] = s
    }
}
// 前進代入
def forward_substitution(a, b, y) {
    for (row in 0..N) {
        for (col in 0..row)
            b[row] -= a[row][col] * y[col]
        y[row] = b[row]
    }
}
// 後退代入
def backward_substitution(a, y, x) {
    for (row = N; row >= 0; row--) {
        for (col = N; col > row; col--)
            y[row] -= a[row][col] * a[row][row] * x[col]
        x[row] = y[row] / a[row][row]
    }
}
// １次元配列を表示
def disp_matrix(matrix) {
    for (row in matrix) {
        for (col in row) {
            printf ("%14.10f\t" , col)
        }
        println()
    }
}
// ２次元配列を表示
def disp_vector(row) {
    for (col in row) {
        printf ("%14.10f\t" , col)
    }
    println()
}
