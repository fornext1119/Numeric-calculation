package main

import "fmt"
import "math"

func main() {
    fmt.Printf("%d\n", 3 + 5)
    fmt.Printf("%d\n", 3 - 5)
    fmt.Printf("%d\n", 3 * 5)
    fmt.Printf("%f\n", math.Pow(3, 5))
    fmt.Printf("%d\n", 5 / 3)
    fmt.Printf("%f\n", 5.0 / 3)
    fmt.Printf("%f\n", 5 / 3.0)
    fmt.Printf("%d\n", 5 % 3)

    fmt.Printf("%3d\n",     3 * 5)
    fmt.Printf("%23.20f\n", 5 / 3.0)
}
