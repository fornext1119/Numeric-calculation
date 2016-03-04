N = 3

// QR分解で固有値を求める
main()

def main() {
    def a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]] as double[][]
    def q = [[0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0]] as double[][]
    def r = [[0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0]] as double[][]

    for (k in 1..200) {
        // QR分解
        decomp(a, q, r)
        // 行列の積
        multiply(r, q, a)
        // 対角要素を表示
        printf("%3d\t" , k)
        disp_eigenvalue(a)

        // 収束判定
        e = 0.0
        for (i in 1..N)
            for (j in 0..(i - 1))
                e += Math.abs(a[i][j])
        if (e < 0.00000000001) break
    }

    println()
    println("eigenvalue")
    disp_eigenvalue(a)
}
// QR分解
def decomp(a, q, r) {
    x = [0.0 ,0.0 ,0.0 ,0.0] as double[]

    for (k in 0..N) {
        for (i in 0..N)
            x[i] = a[i][k]

        if (k > 0) {
	        for (j in 0..(k - 1)) {
	            t = 0.0
	            for (i in 0..N)
	                t += a[i][k] * q[i][j]
	            r[j][k] = t
	            r[k][j] = 0.0
	            for (i in 0..N)
	                x[i] -= t * q[i][j]
	        }
		}

        s = 0.0
        for (i in 0..N)
            s += x[i] * x[i]
        r[k][k] = Math.sqrt(s)
        for (i in 0..N)
            q[i][k] = x[i] / r[k][k]
    }
}
// 行列の積
def multiply(a, b, c) {
    for (i in 0..N) {
        for (j in 0..N) {
            s = 0.0
            for (k in 0..N)
                s += a[i][k] * b[k][j]
            c[i][j] = s
        }
    }
}
// 対角要素を表示
def disp_eigenvalue(a) {
    for (i in 0..N)
        printf("%14.10f\t" , a[i][i])
    println()
}
