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
        x[i] = d
        y[i] = f(d)
    }

    // 0.5刻みで 与えられていない値を補間 
    for i := 0; i <= 18; i++ {
        var d  float64 = float64(i) * 0.5 - 4.5
        var d1 float64 = f(d)
        var d2 float64 = lagrange(d, x[:], y[:])

        // 元の関数と比較
        fmt.Printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d, d1, d2, d1 - d2)
    }
}

// 元の関数
func f(x float64) float64 {
    return x - math.Pow(x,3) / (3 * 2) + math.Pow(x,5) / (5 * 4 * 3 * 2)
}

// Lagrange (ラグランジュ) 補間
func lagrange(d float64, x []float64, y []float64) float64 {
    var sum float64 = 0
    for i := 0; i < N; i++ {
        var prod float64 = y[i]
        for j := 0; j < N; j++ {
            if (j != i) {
                prod *= (d - x[j]) / (x[i] - x[j])
            }
        }
        sum += prod
    }
    return sum
}
