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

println("LL^T")
disp_matrix(a)
println()

// Ly=b から y を求める (前進代入)
y = [0.0,0.0,0.0,0.0]
forward_substitution(a,b,y)

println "Y"
disp_vector(y)

// L^Tx=y から x を求める (後退代入)
x =  [0.0,0.0,0.0,0.0]
backward_substitution(a,y,x)

println("X")
disp_vector(x)

// 前進消去
def forward_elimination(a, b) {
  	for (pivot in 0..N) {
        s = 0
        if (pivot > 0)
            for (col in 0..(pivot-1))
                s += a[pivot][col] * a[pivot][col]
        // ここで根号の中が負の値になると計算できない！
        a[pivot][pivot] = Math.sqrt(a[pivot][pivot] - s)
        
        if (pivot >= N) continue

        for (row in (pivot+1)..N) {
            s = 0
            if (pivot > 0)
                for (col in 0..(pivot-1))
                    s += a[row][col] * a[pivot][col]
            a[row][pivot] = (a[row][pivot] - s) / a[pivot][pivot]
            a[pivot][row] = a[row][pivot]
        }
    }
}
// 前進代入
def forward_substitution(a, b, y) {
    for (row in 0..N) {
        for (col in 0..row)
            b[row] -= a[row][col] * y[col]
        y[row] = b[row] / a[row][row]
    }
}
// 後退代入
def backward_substitution(a, y, x) {
    for (row = N; row >= 0; row--) {
        for (col = N; col > row; col--)
            y[row] -= a[row][col] * x[col]
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
