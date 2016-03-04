package main

import "fmt"
import "math"

const N = 4

func main() {
    var a [N][N]float64 = [N][N]float64{{5.0, 4.0, 1.0, 1.0},
                                        {4.0, 5.0, 1.0, 1.0},
                                        {1.0, 1.0, 4.0, 2.0},
                                        {1.0, 1.0, 2.0, 4.0}}
    var x               = []float64     {1.0 ,0.0 ,0.0 ,0.0}

    // LU分解
    forward_elimination(&a)
    
    // 逆ベキ乗法
    var lambda float64 = inverse(a, x)

    fmt.Println("\neigenvalue")
    fmt.Printf("%14.10f\n", lambda)

    fmt.Println("eigenvector")
    disp_vector(x)
}

// 逆ベキ乗法
func inverse(a[N][N]float64, x0[]float64) float64 {
    var lambda float64 = 0.0

    // 正規化 (ベクトル x0 の長さを１にする)
    normarize(x0)
    var e0 float64 = 0.0
    for i := 0; i < N; i++ {
        e0 += x0[i]
    }

    for k := 1; k < 200; k++ {
        // １次元配列を表示
        fmt.Printf("%3d\t", k)
        disp_vector(x0)

        // Ly = b から y を求める (前進代入)
        var b = []float64 {0.0 ,0.0 ,0.0 ,0.0}
        var y = []float64 {0.0 ,0.0 ,0.0 ,0.0}
        for i := 0; i < N; i++ {
            b[i] = x0[i]
        }
        forward_substitution(a,y,b)
        // Ux = y から x を求める (後退代入)
        var x1 = []float64 {0.0 ,0.0 ,0.0 ,0.0}
        backward_substitution(a,x1,y)

        // 内積
        var p0 float64 = 0.0
        var p1 float64 = 0.0
        for i := 0; i < N; i++ {
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        }
        // 固有値
        lambda = p1 / p0

        // 正規化 (ベクトル x1 の長さを１にする)
        normarize(x1)
        // 収束判定
        var e1 float64 = 0.0
        for i := 0; i < N; i++ {
            e1 += x1[i]
        }
        if (math.Fabs(e0 - e1) < 0.00000000001) {
            break
        }

        for i := 0; i < N; i++ {
            x0[i] = x1[i]
        }
        e0 = e1
    }
    return lambda
}
// LU分解
func forward_elimination(a *[N][N]float64) {
    for pivot := 0; pivot < N - 1; pivot++ {
        for row := pivot + 1; row < N; row++ {
            var s = a[row][pivot] / a[pivot][pivot]
            for col := pivot; col < N; col++ {
                a[row][col] -= a[pivot][col] * s  // これが 上三角行列
            }
            a[row][pivot] = s                     // これが 下三角行列
        }
    }
}
// 前進代入
func forward_substitution(a [N][N]float64, y []float64, b []float64) {
    for row := 0; row < N; row++ { 
        for col := 0; col < row; col++ {
            b[row] -= a[row][col] * y[col]
        }
        y[row] = b[row]
    }
}
// 後退代入
func backward_substitution(a [N][N]float64, x []float64, y []float64) {
    for row := N - 1; row >= 0; row-- {
        for col := N - 1; col > row; col-- {
            y[row] -= a[row][col] * x[col]
        }
        x[row] = y[row] / a[row][row]
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
