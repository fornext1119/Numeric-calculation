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
        var d2 float64 = neville(d, x[:], y[:])

        // 元の関数と比較
        fmt.Printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d, d1, d2, d1 - d2)
    }
}

// 元の関数
func f(x float64) float64 {
    return x - math.Pow(x,3) / (3 * 2) + math.Pow(x,5) / (5 * 4 * 3 * 2)
}

// Neville (ネヴィル) 補間
func neville(d float64, x []float64, y []float64) float64 {
    var w[N][N] float64
    for i := 0; i < N; i++ {
        w[0][i] = y[i]
    }

    for j := 1; j < N; j++ {
        for i := 0; i < N - j; i++ {
              w[j][i] = w[j-1][i+1] + (w[j-1][i+1] - w[j-1][i]) * (d - x[i+j]) / (x[i+j] - x[i])
        }
    }
    
    return w[N-1][0]
}
