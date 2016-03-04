package main

import "fmt"
import "math"

const N = 4

// QR分解で固有値を求める
func main() {
    var a [N][N]float64 = [N][N]float64{{5.0, 4.0, 1.0, 1.0}, 
                                        {4.0, 5.0, 1.0, 1.0}, 
                                        {1.0, 1.0, 4.0, 2.0},
                                        {1.0, 1.0, 2.0, 4.0}}
    var q [N][N]float64 = [N][N]float64{{0.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,0.0}}
    var r [N][N]float64 = [N][N]float64{{0.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,0.0}}

    for k := 1; k < 200; k++ {
        // QR分解
        decomp(a, &q, &r)
        // 行列の積
        multiply(r, q, &a)
        // 対角要素を表示
        fmt.Printf("%3d\t", k)
        disp_eigenvalue(a)
        
        // 収束判定
        var e float64 = 0.0
        for i := 1; i < N; i++ {
            for j := 0; j < i; j++ {
                e += a[i][j] * a[i][j];
            }
        }
        if (e < 0.00000000001) {
            break
        }
    }

    fmt.Println("\neigenvalue")
    disp_eigenvalue(a)
}
// QR分解
func decomp(a[N][N]float64, q *[N][N]float64, r *[N][N]float64) {
    var x = []float64 {0.0 ,0.0 ,0.0 ,0.0}

    for k := 0; k < N; k++ {
        for i := 0; i < N; i++ {
            x[i] = a[i][k]
        }

        for j := 0; j < k; j++ {
            var t float64 = 0.0
            for i := 0; i < N; i++ {
                t += a[i][k] * q[i][j]
            }
            r[j][k] = t
            r[k][j] = 0.0
            for i := 0; i < N; i++ {
                x[i] -= t * q[i][j]
            }
        }

        var s float64 = 0.0
        for i := 0; i < N; i++ {
            s += x[i] * x[i]
        }
        r[k][k] = math.Sqrt(s)
        for i := 0; i < N; i++ {
            q[i][k] = x[i] / r[k][k]
        }
    }
}
// 行列の積
func multiply(a[N][N]float64, b[N][N]float64, c *[N][N]float64) {
    for i := 0; i < N; i++ {
        for j := 0; j < N; j++ {
            var s float64 = 0.0
            for k := 0; k < N; k++ {
                s += a[i][k] * b[k][j]
            }
            c[i][j] = s
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
