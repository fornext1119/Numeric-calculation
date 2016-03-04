package main

import "fmt"
import "math"

// データ点の数
const N   =  7
const Nx2 = 14

func main() {
    var x  [N]float64
    var y  [N]float64
    var yd [N]float64

    // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
    for i := 0; i < N; i++ {
        var d float64 = float64(i) * 1.5 - 4.5
        x[i]  = d
        y[i]  = f(d)
        yd[i] = fd(d)
    }

    // 差分商の表を作る
    var z[Nx2]      float64
    var d[Nx2][Nx2] float64
    for i := 0; i < Nx2; i++ {
        j      := i / 2
        z[i]    = x[j]
        d[0][i] = y[j]
    }

    for i := 1; i < Nx2; i++ {
        for j := 0; j < Nx2 - i; j++ {
            if (i == 1 && j % 2 == 0) {
                d[i][j] = yd[j / 2]
            } else {
                d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (z[j+i] - z[j])
			}
        }
    }

    // ｎ階差分商
    var a[Nx2] float64
    for j := 0; j < Nx2; j++ {
        a[j] = d[j][0]
    }

    // 0.5刻みで 与えられていない値を補間 
    for i := 0; i <= 18; i++ {
        var d  float64 = float64(i) * 0.5 - 4.5
        var d1 float64 = f(d)
        var d2 float64 = hermite(d, z[:], a[:])

        // 元の関数と比較
        fmt.Printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d, d1, d2, d1 - d2)
    }
}

// 元の関数
func f(x float64) float64 {
    return x - math.Pow(x,3) / (3 * 2) + math.Pow(x,5) / (5 * 4 * 3 * 2)
}
// 導関数
func fd(x float64) float64 {
    return 1 - math.Pow(x,2) / 2 + math.Pow(x,4) / (4 * 3 * 2)
}

// Hermite (エルミート) 補間
func hermite(d float64, z []float64, a []float64) float64 {
    var sum float64 = a[0]
    for i := 1; i < Nx2; i++ {
        var prod float64 = a[i]
        for j := 0; j < i; j++ {
            prod *= (d - z[j])
        }
        sum += prod
    }

    return sum
}
