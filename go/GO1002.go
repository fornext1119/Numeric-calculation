package main

import "fmt"
import "math"

const N = 4

func main() {
    var a [N][N]float64 = [N][N]float64{{9,2,1,1},{2,8,-2,1},{-1,-2,7,-2},{1,-1,-2,6}} 
    var b = []float64{20,16,8,17}
    var c = []float64{0,0,0,0}

    // ガウス・ザイデル法
    gauss(a,b,c)

    fmt.Println("X")
    disp_vector(c)
}
// ガウス・ザイデル法
func gauss(a[N][N]float64, b[]float64, x0[]float64) {
    for {
        var finish = true
        for i := 0; i < N; i++ {
            var x1 float64 = b[i]
            for j := 0; j < N; j++ {
                if (j != i) {
                    x1 -= a[i][j] * x0[j]
                }
            }
            x1 /= a[i][i]
            if (math.Fabs(x1 - x0[i]) > 0.0000000001) {
                finish = false
            }
            x0[i] = x1
        }
        if (finish) {
          	return
        }

	    disp_vector(x0)
    }
}
// １次元配列を表示
func disp_vector(row[]float64) {
    for _, col := range row {
        fmt.Printf("%14.10f\t", col)
    }
    fmt.Println("")
}
