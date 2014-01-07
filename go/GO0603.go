package main

import "fmt"
import "math"

func main() {
    const a = 0
    const b = 1

    // Simpson‘¥‚ÅÏ•ª
    var n int = 2
    for j := 1; j <= 5; j++ {
        var h  float64 = (b - a) / float64(n) 
        var s2 float64 = 0
        var s4 float64 = 0
        var x  float64 = a + h
        for i := 1; i <= n / 2; i++ {
            s4 += f(x)
            x  += h
            s2 += f(x)
            x  += h
        }
        s2 = (s2 - f(b)) * 2 + f(a) + f(b)
        s4 *= 4
        var s float64 = (s2 + s4) * h / 3
        n *= 2

        // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
        fmt.Printf("%2d : %13.10f, %13.10f\n", j, s, s - math.Pi)
    }
}

func f(x float64) float64 {
    return (4 / (1 + x * x))
}
