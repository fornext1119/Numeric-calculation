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

    // 差分商の表を作る
    var d[N][N] float64
    for j := 0; j < N; j++ {
        d[0][j] = y[j]
    }
    for i := 1; i < N; i++ {
        for j := 0; j < N - i; j++ {
            d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (x[j+i] - x[j])
        }
    }

    // ｎ階差分商
    var a [N]float64
    for j := 0; j < N; j++ {
        a[j] = d[j][0]
    }

    // 0.5刻みで 与えられていない値を補間 
    for i := 0; i <= 18; i++ {
        var d  float64 = float64(i) * 0.5 - 4.5
        var d1 float64 = f(d)
        var d2 float64 = newton(d, x[:], a[:])

        // 元の関数と比較
        fmt.Printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d, d1, d2, d1 - d2)
    }
}

// 元の関数
func f(x float64) float64 {
    return x - math.Pow(x,3) / (3 * 2) + math.Pow(x,5) / (5 * 4 * 3 * 2)
}

// Newton (ニュートン) 補間
func newton(d float64, x []float64, a []float64) float64 {
    var sum float64 = a[0]
    for i := 1; i < N; i++ {
        var prod float64 = a[i]
        for j := 0; j < i; j++ {
            prod *= (d - x[j])
        }
        sum += prod
    }
    return sum
}
