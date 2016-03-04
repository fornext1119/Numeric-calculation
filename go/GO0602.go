package main

import "fmt"
import "math"

func main() {
    const a = 0
    const b = 1

    // 中点則で積分
    var n int = 2
    for j := 1; j <= 10; j++ {
        var h float64 = (b - a) / float64(n) 
        var s float64 = 0
        var x float64 = a + (h / 2)
        for i := 1; i <= n; i++ {
            s += f(x)
            x += h
        }
        s *= h
        n *= 2

        // 結果を π と比較
        fmt.Printf("%2d : %13.10f, %13.10f\n", j, s, s - math.Pi)
    }
}

func f(x float64) float64 {
    return (4 / (1 + x * x))
}
