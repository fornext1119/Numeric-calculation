package main

import "fmt"
import "math"

func main() {
    var x float64 = 2
    fmt.Printf("%12.10f\n", newton(x))
}

func newton(x0 float64) float64 {
    var x1 float64
    for {
        x1 = x0 - (f0(x0) / f1(x0))
        fmt.Printf("%12.10f\t%13.10f\n", x1, x1 - math.Sqrt(2))

        if math.Fabs(x1 - x0) < 0.0000000001 {
            break
        }
        x0 = x1
    }
    return x1
}

func f0(x float64) float64 {
    return x * x - 2
}
func f1(x float64) float64 {
    return 2 * x
}
