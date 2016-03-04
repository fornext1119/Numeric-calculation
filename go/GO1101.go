package main

import "fmt"
import "math"

const N = 4

// ベキ乗法で最大固有値を求める
func main() {
    var a [N][N]float64 = [N][N]float64{{5.0, 4.0, 1.0, 1.0}, 
                                        {4.0, 5.0, 1.0, 1.0}, 
                                        {1.0, 1.0, 4.0, 2.0},
                                        {1.0, 1.0, 2.0, 4.0}}
    var x               = []float64     {1.0 ,0.0 ,0.0 ,0.0}

    // ベキ乗法
    var lambda float64 = power(a, x)

    fmt.Println("\neigenvalue")
    fmt.Printf("%14.10f\n", lambda)

    fmt.Println("eigenvector")
    disp_vector(x)
}

// ベキ乗法
func power(a[N][N]float64, x0[]float64) float64 {
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

        // 行列の積 x1 = A × x0 
        var x1 = []float64  {0.0 ,0.0 ,0.0 ,0.0}
        for i := 0; i < N; i++ {
            for j := 0; j < N; j++ {
                x1[i] += a[i][j] * x0[j]
            }
        }
        
        // 内積
        var p0 float64 = 0.0
        var p1 float64 = 0.0
        for i := 0; i < N; i++ {
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        }
        // 固有値
        lambda = p0 / p1

        // 正規化 (ベクトル x1 の長さを１にする)
        normarize(x1)
        var e1 float64 = 0.0
        // 収束判定
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
