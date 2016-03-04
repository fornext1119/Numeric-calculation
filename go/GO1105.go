// 対称行列 {\boldsymbol A} に、正則行列 {\boldsymbol P} の転置行列 {\boldsymbol P}^T と正則行列 {\boldsymbol P} を左右からかけてできた行列
// {\boldsymbol B}={\boldsymbol P}^T{\boldsymbol A}{\boldsymbol P}
// の固有値と固有ベクトルは元の行列 {\boldsymbol A}から変化しない.
// この処理を反復すると, 固有値が対角成分に並んだ対角行列に収束する.
// {\boldsymbol \varLambda}=
// {\boldsymbol P}_n^T\ldots{\boldsymbol P}_2^T{\boldsymbol P}_1^T
// {\boldsymbol A}
// {\boldsymbol P}_1{\boldsymbol P}_2\ldots{\boldsymbol P}_n

// {\boldsymbol A} の非対角成分のうち絶対値が最大の成分を a_{ij} とするとき,
// p_{ii} =&  \cos\theta \\
// p_{jj} =&  \cos\theta \\
// p_{ij} =& -\sin\theta \\
// p_{ji} =&  \sin\theta
// その他の対角成分を 1, その他の非対角成分を 0 とした行列 {\boldsymbol P} を考える.
// {\boldsymbol P}= 
// \begin{bmatrix}
// 1       & 0             & \ldots        & \ldots        & 0 \\
// 0       & \cos\theta    & \ldots        & -\sin\theta   & \vdots \\ 
// \vdots  & \vdots        & \ddots        & \vdots        & \vdots \\ 
// \vdots  & \sin\theta    & \ldots        & \cos\theta    & 0 \\ 
// 0       & \ldots        & \ldots        & 0             & 1 
// \end{bmatrix}
//  
// このとき, a_{ij} = a_{ji} = 0 となるように \theta の値を設定する.


package main

import "fmt"
import "math"

const N = 4

// ヤコビ法で固有値を求める
func main() {
    var a [N][N]float64 = [N][N]float64{{5.0, 4.0, 1.0, 1.0},
                                        {4.0, 5.0, 1.0, 1.0},
                                        {1.0, 1.0, 4.0, 2.0},
                                        {1.0, 1.0, 2.0, 4.0}}
    var v [N][N]float64 = [N][N]float64{{1.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,1.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,1.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,1.0}}

    // ヤコビ法
    jacobi(&a, &v)

    fmt.Println("\neigenvalue")
    disp_eigenvalue(a)

    fmt.Println("\neigenvector")
    disp_eigenvector(v)
}

// ヤコビ法
func jacobi(a *[N][N]float64, v *[N][N]float64) {
    for k := 1; k < 100; k++ {
        // 最大値を探す
        var p int = 0
        var q int = 0
        var max_val float64 = 0.0
        for i := 0; i < N; i++ {
            for j := i + 1; j < N; j++ {
                if (max_val < math.Abs(a[i][j])) {
                    max_val = math.Abs(a[i][j])
                    p = i
                    q = j
                }
            }
        }

        // θ を求める
        var t float64 = 0.0
        if (math.Abs(a[p][p] - a[q][q]) < 0.00000000001) {
            // a_{pp} ＝ a_{qq} のとき、回転角θをπ/4にする
            t = math.Pi / 4.0
            if (a[p][p] < 0) {
                t = -t
            }
        } else {
            // a_{pp} ≠ a_{qq} のとき
            t = math.Atan(2.0 * a[p][q] / (a[p][p] - a[q][q])) / 2.0
        }

        // θ を使って 行列 P を作成し、A = P^t × A × P
        var c float64 = math.Cos(t)
        var s float64 = math.Sin(t)
        // P^t × A
        var t1 float64 = 0.0
        var t2 float64 = 0.0
        for i := 0; i < N; i++ {
            t1      =  a[p][i] * c + a[q][i] * s
            t2      = -a[p][i] * s + a[q][i] * c
            a[p][i] = t1
            a[q][i] = t2
            // 固有ベクトル
            t1      =  v[p][i] * c + v[q][i] * s
            t2      = -v[p][i] * s + v[q][i] * c
            v[p][i] = t1
            v[q][i] = t2
        }
        // A × P
        for i := 0; i < N; i++ {
            t1      =  a[i][p] * c + a[i][q] * s
            t2      = -a[i][p] * s + a[i][q] * c
            a[i][p] = t1
            a[i][q] = t2
        }

        // 対角要素を表示
        fmt.Printf("%3d\t", k)
        disp_eigenvalue(*a)

        // 収束判定
        if (max_val < 0.00000000001) {
            break
        }
    }
}

// 対角要素を表示
func disp_eigenvalue(a[N][N]float64) {
    for i := 0; i < N; i++ {
        fmt.Printf("%14.10f\t", a[i][i])
    }
    fmt.Println("")
}
// 固有ベクトルを表示
func disp_eigenvector(matrix[N][N]float64) {
    for i := 0; i < N; i++ {
        var row = []float64 {0.0 ,0.0 ,0.0 ,0.0}
        for j := 0; j < N; j++ {
            row[j] = matrix[i][j]
        } 
        normarize(row)
        disp_vector(row)
    }
}
// １次元配列を表示
func disp_vector(row[]float64) {
    for _, col := range row {
        fmt.Printf("%14.10f\t", col)
    }
    fmt.Println("")
}
// 正規化 (ベクトルの長さを１にする)
func normarize(x[]float64) {
    var s float64 = 0.0

    for i := 0; i < N; i++ {
        s += x[i] * x[i]
    }
    s = math.Sqrt(s)
    
    for i := 0; i < N; i++ {
        x[i] /= s
    }
}
