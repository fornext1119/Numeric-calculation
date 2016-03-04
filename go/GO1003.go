package main

import "fmt"
import "math"

const N = 4

// ガウスの消去法
func main() {
    var a [N][N]float64 = [N][N]float64{{-1,-2,7,-2},{1,-1,-2,6},{9,2,1,1},{2,8,-2,1}} 
    var b []float64     = []float64{8,17,20,16}

    // ピボット選択
    pivoting(&a,b)

    fmt.Println("pivoting")
    fmt.Println("A")
	disp_matrix(a);
    fmt.Println("B")
    disp_vector(b);
    fmt.Println()

    // 前進消去
    forward_elimination(&a,b)

    fmt.Println("forward elimination")
    fmt.Println("A")
	disp_matrix(a);
    fmt.Println("B")
    disp_vector(b);
    fmt.Println()

    // 後退代入
    backward_substitution(&a,b)

    fmt.Println("X")
    disp_vector(b);
}
// 前進消去
func forward_elimination(a *[N][N]float64, b []float64) {
    for pivot := 0; pivot < N - 1; pivot++ { 
        for row := pivot + 1; row < N; row++ {
            var s = a[row][pivot] / a[pivot][pivot]
            for col := pivot; col < N; col++ {
                a[row][col] -= a[pivot][col]    * s
			}
            b[row]          -= b[pivot]         * s
        }
    }
}
// 後退代入
func backward_substitution(a *[N][N]float64, b []float64) {
    for row := N - 1; row >= 0; row-- { 
        for col := N - 1; col > row; col-- {
            b[row] -= a[row][col] * b[col]
		}
        b[row] /= a[row][row]
    }
}
// ピボット選択
func pivoting(a *[N][N]float64, b []float64) {
    for pivot := 0; pivot < N; pivot++ { 
        // 各列で 一番値が大きい行を 探す
        var max_row         = pivot
        var max_val float64 = 0.0
        for row := pivot; row < N; row++ { 
            if math.Fabs(a[row][pivot]) > max_val {
                // 一番値が大きい行
                max_val =   math.Fabs(a[row][pivot])
                max_row =   row
            }
        }

        // 一番値が大きい行と入れ替え
        if (max_row != pivot) {
            var tmp float64 = 0.0
            for col := 0; col < N; col++ {
                tmp             =   a[max_row][col]
                a[max_row][col] =   a[pivot][col]
                a[pivot][col]   =   tmp
            }
            tmp         =   b[max_row]
            b[max_row]  =   b[pivot]
            b[pivot]    =   tmp
        }
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
