N = 3

// 逆ベキ乗法で最小固有値を求める
main()

def main() {
    def a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]] as double[][]
    def x =  [1.0 ,0.0 ,0.0 ,0.0]  as double[]

    // LU分解
    forward_elimination(a)

    // 逆ベキ乗法
    lambda = inverse(a, x)

    println()
    println("eigenvalue")
    printf("%14.10f\n" , lambda)

    println("eigenvector")
    disp_vector(x)
}

// 逆ベキ乗法
def inverse(a, x0) {
    lambda = 0.0

    // 正規化 (ベクトル x0 の長さを１にする)
    normarize(x0)
    e0 = 0.0
    for (i in 0..N)
        e0 += x0[i]

    for (k in 1..200) {
        // １次元配列を表示
        printf("%3d\t" , k)
        disp_vector(x0)

        // Ly=b から y を求める (前進代入)
        b = [0.0,0.0,0.0,0.0]
        y = [0.0,0.0,0.0,0.0]
        for (i in 0..N)
            b[i] = x0[i]
        forward_substitution(a,y,b)

        // Ux=y から x を求める (後退代入)
        x1 = [0.0,0.0,0.0,0.0]
        backward_substitution(a,x1,y)

        // 内積
        p0 = 0.0
        p1 = 0.0
        for (i in 0..N) {
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        }
        // 固有値
        lambda = p1 / p0

        // 正規化 (ベクトル x1 の長さを１にする)
        normarize(x1)
        // 収束判定
        e1 = 0.0
        for (i in 0..N)
            e1 += x1[i]
        if (Math.abs(e0 - e1) < 0.00000000001) break

        for (i in 0..N)
            x0[i] = x1[i]
        e0 = e1
    }
    lambda
}

// 前進消去
def forward_elimination(a) {
    for (pivot in 0..(N - 1)) {
        for (row in (pivot + 1)..N) {
            s = a[row][pivot] / a[pivot][pivot]
            for (col in pivot..N)
                a[row][col] -= a[pivot][col] * s // これが 上三角行列
            a[row][pivot]    = s                 // これが 下三角行列
        }
    }
}
// Ly=b から y を求める (前進代入)
def forward_substitution(a, y, b) {
    for (row in 0..N) {
        for (col in 0..row)
            b[row] -= a[row][col] * y[col]
        y[row] = b[row]
    }
}
// Ux=y から x を求める (後退代入)
def backward_substitution(a, x, y) {
    for (row = N; row >= 0; row--) {
        for (col = N; col > row; col--)
            y[row] -= a[row][col] * x[col]
        x[row] = y[row] / a[row][row]
    }
}
// １次元配列を表示
def disp_vector(row) {
    for (col in row) {
        printf("%14.10f\t" , col)
    }
    println()
}
// 正規化 (ベクトルの長さを１にする)
def normarize(x) {
    s = 0.0

    for (i in 0..N)
        s += x[i] * x[i]
    s = Math.sqrt(s)

    for (i in 0..N)
        x[i] /= s
}
