N = 3

// ハウスホルダー変換とQR分解で固有値を求める
main()

def main() {
    def a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]] as double[][]
    def d =  [1.0 ,0.0 ,0.0 ,0.0]  as double[]
    def e =  [1.0 ,0.0 ,0.0 ,0.0]  as double[]

    // ハウスホルダー変換
    tridiagonalize(a, d, e)

    // QR分解
    decomp(a, d, e)

    println()
    println("eigenvalue")
    disp_vector(d)

    println()
    println("eigenvector")
    disp_matrix(a)
}

// ハウスホルダー変換
def tridiagonalize(a, d, e) {
    def v =  [0.0 ,0.0 ,0.0 ,0.0] as double[]

    for (k in 0..(N - 2)) {
        def w = [0.0 ,0.0 ,0.0 ,0.0] as double[]
        d[k] = a[k][k]

        t = 0.0
        for (i in (k + 1)..N) {
            w[i] =  a[i][k]
            t    += w[i] * w[i]
        }
        s = Math.sqrt(t)
        if (w[k + 1] < 0) s = -s

        if (Math.abs(s) < 0.00000000001)
            e[k + 1] = 0.0
        else {
            e[k + 1]  = -s
            w[k + 1] +=  s
            s = 1 / Math.sqrt(w[k + 1] * s)
	        for (i in (k + 1)..N)
                w[i] *= s

	        for (i in (k + 1)..N) {
                s = 0.0
                for (j in (k + 1)..N) {
                    if (j <= i)
                        s += a[i][j] * w[j]
                    else
                        s += a[j][i] * w[j]
                }
                v[i] = s
            }

            s = 0.0
	        for (i in (k + 1)..N)
                s += w[i] * v[i]
            s /= 2.0
	        for (i in (k + 1)..N)
                v[i] -= s * w[i]
	        for (i in (k + 1)..N)
                for (j in (k + 1)..i)
                    a[i][j] -= w[i] * v[j] + w[j] * v[i]
            // 次の行は固有ベクトルを求めないなら不要
	        for (i in (k + 1)..N)
                a[i][k] = w[i]
        }
    }

    d[N - 1] = a[N - 1][N - 1]
    d[N]     = a[N][N]

    e[0]     = 0.0
    e[N]     = a[N][N - 1]

    // 次の行は固有ベクトルを求めないなら不要
    for (k in N..0) {
        w = [0.0 ,0.0 ,0.0 ,0.0]
        if (k < N - 1) {
            for (i in (k + 1)..N)
                w[i] = a[i][k]
            for (i in (k + 1)..N) {
                s = 0.0
                for (j in (k + 1)..N)
                    s += a[i][j] * w[j]
                v[i] = s
            }
            for (i in (k + 1)..N)
                for (j in (k + 1)..N)
                    a[i][j] -= v[i] * w[j]
        }
        for (i in 0..N)
            a[i][k] = 0.0
        a[k][k] = 1.0
    }
}

// QR分解
def decomp(a, d, e) {
    e[0] = 1.0
    h = N - 1
    while (Math.abs(e[h]) < 0.00000000001) h--

    while (h > 0) {
        e[0] = 0.0
        l = h - 1
        while (Math.abs(e[l]) >= 0.00000000001) l--

        for (j in 1..100) {
            w = (d[h - 1] - d[h]) / 2.0
            s = Math.sqrt(w * w + e[h] * e[h])
            if (w < 0.0) s = -s

            x = d[l] - d[h] + e[h] * e[h] / (w + s)
            y = e[l + 1]
            z = 0.0
            t = 0.0
            u = 0.0
            for (k in l..(h - 1)) {
                if (Math.abs(x) >= Math.abs(y)) {
                    t = -y / x
                    u = 1 / Math.sqrt(t * t + 1.0)
                    s = t * u
                }
				else {
                    t = -x / y
                    s = 1 / Math.sqrt(t * t + 1.0)
                    if (t < 0)
                        s = -s
                    u = t * s
                }

                w = d[k] - d[k + 1]
                t = (w * s + 2 * u * e[k + 1]) * s
                d[k    ] = d[k    ] - t
                d[k + 1] = d[k + 1] + t
                e[k    ] = u * e[k] - s * z
                e[k + 1] = e[k + 1] * (u * u - s * s) + w * s * u

                // 次の行は固有ベクトルを求めないなら不要
	            for (i in 0..N) {
                    x = a[k    ][i]
                    y = a[k + 1][i]
                    a[k    ][i] = u * x - s * y
                    a[k + 1][i] = s * x + u * y
                }

                if (k < N - 1) {
                    x = e[k + 1]
                    y = -s * e[k + 2]
                    z = y
                    e[k + 2] = u * e[k + 2]
                }
            }

        	printf("%3d\t" , j)
            disp_vector(d)

            // 収束判定
            if (Math.abs(e[h]) < 0.00000000001) break
        }

        e[0] = 1.0
        while (Math.abs(e[h]) < 0.00000000001) h--
    }

    // 次の行は固有ベクトルを求めないなら不要
    for (k in 0..(N - 1)) {
        l = k
        for (i in (k + 1)..N)
            if (d[i] > d[l])
                l = i

        t    = d[k]
        d[k] = d[l]
        d[l] = t

        for (i in 0..N) {
            t       = a[k][i]
            a[k][i] = a[l][i]
            a[l][i] = t
        }
    }
}

// １次元配列を表示
def disp_vector(row) {
    for (col in row) {
        printf("%14.10f\t" , col)
    }
    println()
}
// ２次元配列を表示
def disp_matrix(matrix) {
    for (row in matrix) {
	    for (col in row) {
	        printf("%14.10f\t" , col)
	    }
	    println()
    }
}
