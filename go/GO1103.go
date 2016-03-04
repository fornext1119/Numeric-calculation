package main

import "fmt"

const N = 4

// LR分解で固有値を求める
func main() {
    var a [N][N]float64 = [N][N]float64{{5.0, 4.0, 1.0, 1.0}, 
                                        {4.0, 5.0, 1.0, 1.0}, 
                                        {1.0, 1.0, 4.0, 2.0},
                                        {1.0, 1.0, 2.0, 4.0}}
    var l [N][N]float64 = [N][N]float64{{0.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,0.0}}
    var u [N][N]float64 = [N][N]float64{{0.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,0.0},
                                        {0.0 ,0.0 ,0.0 ,0.0}}

    for k := 1; k < 200; k++ {
        // LU分解
        decomp(a, &l, &u)
        // 行列の積
        multiply(u, l, &a)
        // 対角要素を表示
        fmt.Printf("%3d\t", k)
        disp_eigenvalue(a)
        
        // 収束判定
        var e float64 = 0.0
        for i := 1; i < N; i++ {
            for j := 0; j < i; j++ {
                e += a[i][j] * a[i][j]
            }
        }
        if (e < 0.00000000001) {
            break
        }
    }

    fmt.Println("\neigenvector")
    disp_eigenvalue(a)
}
// LU分解
func decomp(a[N][N]float64, l *[N][N]float64, u *[N][N]float64) {
    for i := 0; i < N; i++ {
        for j := 0; j < N; j++ {
            l[i][j] = 0.0
            u[i][j] = 0.0
        }
    }
    
    l[0][0] = 1.0
    for j := 0; j < N; j++ {
        u[0][j] = a[0][j]
    }

    for i := 1; i < N; i++ {
        u[i][0] = 0.0
        l[0][i] = 0.0
        l[i][0] = a[i][0] / u[0][0]
    }
    for i := 1; i < N; i++ {
        l[i][i] = 1.0
        var t float64 = a[i][i]
        for k := 0; k <= i; k++ {
            t -= l[i][k] * u[k][i]
        }
        u[i][i] = t
        for j := i + 1; j < N; j++ {
            u[j][i] = 0.0
            l[i][j] = 0.0
            t       = a[j][i]
            for k := 0; k <= i; k++ {
                t -= l[j][k] * u[k][i]
            }
            l[j][i] = t / u[i][i]
            t       = a[i][j]
            for k := 0; k <= i; k++ {
                t -= l[i][k] * u[k][j]
            }
            u[i][j] = t
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
