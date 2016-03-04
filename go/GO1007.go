package main

import "fmt"

const N = 4

// 修正コレスキー法
func main() {
    var a [N][N]float64 = [N][N]float64{{5,2,3,4},{2,10,6,7},{3,6,15,9},{4,7,9,20}} 
    var b []float64     = []float64{34,68,96,125}

    fmt.Println("A")
	disp_matrix(a)
    fmt.Println("B")
    disp_vector(b)
    fmt.Println()

    // 前進消去
    forward_elimination(&a,b)

    fmt.Println("LDL^T")
	disp_matrix(a)

    // Ly=b から y を求める (前進代入)
    var y []float64 = []float64{0,0,0,0}
    forward_substitution(a,b,y)

    fmt.Println("Y")
    disp_vector(y)

    // DL^Tx=y から x を求める (後退代入)
    var x []float64 = []float64{0,0,0,0}
    backward_substitution(a,y,x)

    fmt.Println("X")
    disp_vector(x)
}
// 前進消去
func forward_elimination(a *[N][N]float64, b []float64) {
    for pivot := 0; pivot < N; pivot++ { 
        var s = 0.0

        // pivot < k の場合
        for col := 0; col < pivot; col++ {
            s = a[pivot][col]
            for k := 0; k < col; k++ {
                s -= a[pivot][k] * a[col][k] * a[k][k]
            }
            a[pivot][col] = s / a[col][col]
            a[col][pivot] = a[pivot][col]
        }
 
        // pivot == k の場合
        s = a[pivot][pivot]
        for k := 0; k < pivot; k++ {
            s -= a[pivot][k] * a[pivot][k] * a[k][k]
        }
        a[pivot][pivot] = s
    }
}
// 前進代入
func forward_substitution(a [N][N]float64, b []float64, y []float64) {
    for row := 0; row < N; row++ { 
        for col := 0; col < row; col++ {
            b[row] -= a[row][col] * y[col]
        }
        y[row] = b[row]
    }
}
// 後退代入
func backward_substitution(a [N][N]float64, y []float64, x []float64) {
    for row := N - 1; row >= 0; row-- {
        for col := N - 1; col > row; col-- {
            y[row] -= a[col][row] * a[row][row] * x[col]
        }
        x[row] = y[row] / a[row][row]
    }
}
// １次元配列を表示
func disp_vector(row[]float64) {
    for _, col := range row {
        fmt.Printf("%14.10f\t", col)
    }
    fmt.Println("")
}
// ２次元配列を表示
func disp_matrix(matrix[N][N]float64) {
    for _, row := range matrix {
	    for _, col := range row {
	        fmt.Printf("%14.10f\t", col)
	    }
	    fmt.Println("")
	}
}
