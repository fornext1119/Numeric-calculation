package main

import "fmt"
import "math"

func main() {
    var x float64 = 1
    fmt.Printf("%12.10f\n", iterative(x))
}

func iterative(x0 float64) float64 {
    var x1 float64
    for {
        x1 = g(x0)
        fmt.Printf("%12.10f\t%13.10f\n", x1, x1 - math.Sqrt(2))

        if math.Fabs(x1 - x0) < 0.0000000001 {
            break
        }
        x0 = x1
    }
    return x1
}

func g(x float64) float64 {
    return (x / 2) + (1 / x)
}
