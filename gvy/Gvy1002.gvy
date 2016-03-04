N = 3

def a = [[ 9.0,  2.0, 1.0,  1.0], [2.0, 8.0, -2.0, 1.0], [-1.0, -2.0, 7.0, -2.0], [1.0, -1.0, -2.0, 6.0]]  as double[][]
def b =  [20.0, 16.0, 8.0, 17.0] as double[]
def c =  [ 0.0,  0.0, 0.0,  0.0] as double[]

// ガウス・ザイデル法
gauss(a,b,c)

println("X")
disp_vector(c)

// ガウス・ザイデル法
def gauss(a, b, x0) {
    def x1 =  [ 0.0,  0.0, 0.0,  0.0] as double[]

    while (true) {
        def finish = true
        for (i in 0..N ) {
            x1[i] = 0
            for (j in 0..N ) {
                if (j != i)
                    x1[i] += a[i][j] * x0[j]
            }
            x1[i] = (b[i] - x1[i]) / a[i][i]
            if (Math.abs(x1[i] - x0[i]) > 0.0000000001)
                finish = false
            x0[i] = x1[i]
        }
        if (finish) return

        disp_vector(x0)
    }
}

// １次元配列を表示
def disp_vector(row) {
    for (col in row) {
        printf ("%14.10f\t" , col)
    }
    println()
}
