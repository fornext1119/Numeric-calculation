package main

import "fmt"
import "math"

func main() {
    var a float64 = 1
    var b float64 = 2
    fmt.Printf("%12.10f\n", falseposition(a, b))
}

func falseposition(a float64, b float64) float64 {
    var c float64
    for {
        // 点 (a,f(a)) と 点 (b,f(b)) を結ぶ直線と x軸の交点
        c = (a * f(b) - b * f(a)) / (f(b) - f(a))
        fmt.Printf("%12.10f\t%13.10f\n", c, c - math.Sqrt(2))

        var fc float64 = f(c)
        if math.Fabs(fc) < 0.0000000001 {
            break
        }
        if fc < 0 {
            // f(c) < 0 であれば, 解は区間 (c, b) の中に存在
            a = c
        } else {
            // f(c) > 0 であれば, 解は区間 (a, c) の中に存在
            b = c
        }
    }
    return c
}

func f(x float64) float64 {
    return x * x - 2
}
