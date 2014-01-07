package main

import "fmt"
import "math"

func main() {
    const a = 0
    const b = 1

    var t[7][7] float64

    // ‘äŒ`‘¥‚ÅÏ•ª
    var n int = 2
    for i := 1; i <= 6; i++ {
        var h float64 = (b - a) / float64(n) 
        var s float64 = 0
        var x float64 = a
        for j := 1; j <= n - 1; j++ {
            x += h
            s += f(x)
        }
        // Œ‹‰Ê‚ğ•Û‘¶
        t[i][1] = h * ((f(a) + f(b)) / 2 + s)
        n *= 2
    }

    // Richardson‚Ì•âŠO–@
    n = 4
    for j := 2; j <= 6; j++ {
        for i := j; i <= 6; i++ {
            t[i][j] = t[i][j - 1] + (t[i][j - 1] - t[i - 1][j - 1]) / float64(n - 1)
            if i == j {
                // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
                fmt.Printf("%2d : %13.10f, %13.10f\n", j, t[i][j], t[i][j] - math.Pi)
            }
        }
        n *= 4
    }

}

func f(x float64) float64 {
    return (4 / (1 + x * x))
}
