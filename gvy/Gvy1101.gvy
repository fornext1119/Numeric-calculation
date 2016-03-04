N = 3

// ベキ乗法で最大固有値を求める
main()

def main() {
    def a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]] as double[][]
    def x =  [1.0 ,0.0 ,0.0 ,0.0]  as double[]

    // ベキ乗法
    lambda = power(a, x)

    println()
    println("eigenvalue")
    printf("%14.10f\n" , lambda)

    println("eigenvector")
    disp_vector(x)
}

// ベキ乗法
def power(a, x0) {
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

        // 行列の積 x1 = A × x0
        x1 = [0.0 ,0.0 ,0.0 ,0.0]
        for (i in 0..N)
            for (j in 0..N)
                x1[i] += a[i][j] * x0[j]

        // 内積
        p0 = 0.0
        p1 = 0.0
        for (i in 0..N) {
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        }
        // 固有値
        lambda = p0 / p1

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
