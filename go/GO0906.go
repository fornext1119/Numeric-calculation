package main

import "fmt"
import "math"

func main() {
    var x0 float64 = 1
    var x1 float64 = 2
    fmt.Printf("%12.10f\n", secant(x0, x1))
}

func secant(x0 float64, x1 float64) float64 {
    var x2 float64
    for {
        x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
        fmt.Printf("%12.10f\t%13.10f\n", x2, x2 - math.Sqrt(2))

        if math.Fabs(x2 - x1) < 0.0000000001 {
            break
        }
        x0 = x1
        x1 = x2
    }
    return x2
}

func f(x float64) float64 {
    return x * x - 2
}
