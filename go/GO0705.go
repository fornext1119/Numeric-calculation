package main

import "fmt"
import "math"

// データ点の数
const N = 7

func main() {
    var x [N]float64
    var y [N]float64

    // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
    for i := 0; i < N; i++ {
        var d float64 = float64(i) * 1.5 - 4.5
        x[i]  = d
        y[i]  = f(d)
    }

    // ３項方程式の係数の表を作る
    var a [N]float64
    var b [N]float64
    var c [N]float64
    var d [N]float64
    for i := 1; i < N - 1; i++ {
        a[i] =         x[i]   - x[i-1] 
        b[i] = 2.0 *  (x[i+1] - x[i-1])
        c[i] =         x[i+1] - x[i] 
        d[i] = 6.0 * ((y[i+1] - y[i]) / (x[i+1] - x[i]) - (y[i] - y[i-1]) / (x[i] - x[i-1]))
    }

    // ３項方程式を解く (ト－マス法)
    var g [N]float64
    var s [N]float64
    g[1] = b[1]
    s[1] = d[1]
    for i := 2; i < N - 1; i++ {
        g[i] = b[i] - a[i] * c[i-1] / g[i-1]
        s[i] = d[i] - a[i] * s[i-1] / g[i-1]
    }
    var z [N]float64
    z[0]   = 0
    z[N-1] = 0
    z[N-2] = s[N-2] / g[N-2]
    for i := N - 3; i >= 1; i-- {
        z[i] = (s[i] - c[i] * z[i+1]) / g[i]
    }

    // 0.5刻みで 与えられていない値を補間 
    for i := 0; i <= 18; i++ {
        var d1 float64 = float64(i) * 0.5 - 4.5
        var d2 float64 = f(d1)
        var d3 float64 = spline(d1, x[:], y[:], z[:])

        // 元の関数と比較
        fmt.Printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d1, d2, d3, d2 - d3)
    }
}

// 元の関数
func f(x float64) float64 {
    return x - math.Pow(x,3) / (3 * 2) + math.Pow(x,5) / (5 * 4 * 3 * 2)
}

// Spline (スプライン) 補間
func spline(d float64, x []float64, y []float64, z []float64) float64 {
    // 補間関数値がどの区間にあるか
    k := -1
    for i := 1; i < N; i++ {
        if d <= x[i] {
            k = i - 1
            break
        }
    }
    if k < 0 {
        k = N - 1
	}

    var d1 float64 = x[k+1] - d
    var d2 float64 = d      - x[k]
    var d3 float64 = x[k+1] - x[k]
    return (z[k] * math.Pow(d1,3) + z[k+1] * math.Pow(d2,3)) / (6.0 * d3) +
           (y[k]   / d3 - z[k]   * d3 / 6.0) * d1                         +
           (y[k+1] / d3 - z[k+1] * d3 / 6.0) * d2
}
