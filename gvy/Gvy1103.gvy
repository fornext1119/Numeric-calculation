N = 3

// LR分解で固有値を求める
main()

def main() {
    def a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]] as double[][]
    def l = [[0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0]] as double[][]
    def u = [[0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0]] as double[][]

    for (k in 1..200) {
        // LU分解
        decomp(a, l, u)
        // 行列の積
        multiply(u, l, a)
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
// LU分解
def decomp(a, l, u) {
    for (i in 0..N) {
        for (j in 0..N) {
            l[i][j] = 0.0
            u[i][j] = 0.0
        }
    }

    l[0][0] = 1.0
    for (j in 0..N)
        u[0][j] = a[0][j]

    for (i in 1..N) {
        u[i][0] = 0.0
        l[0][i] = 0.0
        l[i][0] = a[i][0] / u[0][0]
    }
    for (i in 1..N) {
        l[i][i] = 1.0
        t = a[i][i]
        for (k in 0..i)
            t -= l[i][k] * u[k][i]
        u[i][i] = t
		if (i < N) {
	        for (j in (i + 1)..N) {
	            u[j][i] = 0.0
	            l[i][j] = 0.0
	            t       = a[j][i]
	            for (k in 0..i)
	                t -= l[j][k] * u[k][i]
	            l[j][i] = t / u[i][i]
	            t       = a[i][j]
	            for (k in 0..i)
	                t -= l[i][k] * u[k][j]
	            u[i][j] = t
	        }
		}
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
