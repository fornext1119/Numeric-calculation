http://mcn-www.jwu.ac.jp/~yokamoto/openwww/num/matrix2/readme.pdf


対称行列 {\boldsymbol A} を, 以下のように分割する.
{\boldsymbol A}= 
\left[
\begin{array}{c|ccc}
a_{11} & & {\boldsymbol b}^T & \\ \hline
 & & & \\
{\boldsymbol b} & & {\boldsymbol C} & \\
 & & &
\end{array}
\right]

それに対応する, 以下のような行列 {\boldsymbol P} を考える.
{\boldsymbol P}= 
\left[
\begin{array}{c|ccc}
1 & & {\boldsymbol 0}^T & \\ \hline
 & & & \\
{\boldsymbol 0} & & {\boldsymbol Q} & \\
 & & &
\end{array}
\right]

{\boldsymbol A} に、左右から行列 {\boldsymbol P} と {\boldsymbol P}^T をかける.
{\boldsymbol P}^T{\boldsymbol A}{\boldsymbol P}
=
\left[
\begin{array}{c|ccc}
1 & & {\boldsymbol 0}^T & \\ \hline
 & & & \\
{\boldsymbol 0} & & {\boldsymbol Q} & \\
 & & &
\end{array}
\right]
\left[
\begin{array}{c|ccc}
a_{11} & & {\boldsymbol b}^T & \\ \hline
 & & & \\
{\boldsymbol b} & & {\boldsymbol C} & \\
 & & &
\end{array}
\right]
\left[
\begin{array}{c|ccc}
1 & & {\boldsymbol 0}^T & \\ \hline
 & & & \\
{\boldsymbol 0} & & {\boldsymbol Q} & \\
 & & &
\end{array}
\right] \\


{\boldsymbol P}^T{\boldsymbol A}{\boldsymbol P}
=
\left[
\begin{array}{c|ccc}
1 & & {\boldsymbol 0}^T & \\ \hline
 & & & \\
{\boldsymbol 0} & & {\boldsymbol Q} & \\
 & & &
\end{array}
\right]
\left[
\begin{array}{c|ccc}
a_{11} & & {\boldsymbol b}^T{\boldsymbol Q} & \\ \hline
 & & & \\
{\boldsymbol b} & & {\boldsymbol C}{\boldsymbol Q} & \\
 & & &
\end{array}
\right] \\


{\boldsymbol P}^T{\boldsymbol A}{\boldsymbol P}
=
\left[
\begin{array}{c|ccc}
a_{11} & & {\boldsymbol b}^T{\boldsymbol Q} & \\ \hline
 & & & \\
{\boldsymbol Q}{\boldsymbol b} & & {\boldsymbol Q}{\boldsymbol C}{\boldsymbol Q} & \\
 & & &
\end{array}
\right] \\


{\boldsymbol b}^T{\boldsymbol Q}
=
\left(
\begin{array}
\! \| {\boldsymbol b} \| \;　 0  \ldots 0
\end{array}
\right)
package main

import "fmt"
import "math"

const N = 4

// ハウスホルダー変換とQR分解で固有値を求める
func main() {
    var a [N][N]float64 = [N][N]float64{{5.0, 4.0, 1.0, 1.0},
                                        {4.0, 5.0, 1.0, 1.0},
                                        {1.0, 1.0, 4.0, 2.0},
                                        {1.0, 1.0, 2.0, 4.0}}
    var d               = []float64     {0.0 ,0.0 ,0.0 ,0.0}
    var e               = []float64     {0.0 ,0.0 ,0.0 ,0.0}

    // ハウスホルダー変換
    tridiagonalize(&a, d, e)

    // QR分解
    decomp(&a, d, e)

    fmt.Println("\neigenvalue")
    disp_vector(d)

    fmt.Println("\neigenvector")
    disp_matrix(a)
}

// ハウスホルダー変換
func tridiagonalize(a *[N][N]float64, d []float64, e []float64) {
    var v = []float64 {0.0 ,0.0 ,0.0 ,0.0}
    
    for k := 0; k < N - 2; k++ {
        var w = []float64 {0.0 ,0.0 ,0.0 ,0.0}
        d[k] = a[k][k]

        var t float64 = 0.0
        for i := k + 1; i < N; i++ {
            w[i] =  a[i][k]
            t    += w[i] * w[i]
        }
        var s float64 = math.Sqrt(t)
        if (w[k + 1] < 0) {
            s = -s
		}

        if (math.Fabs(s) < 0.00000000001) {
            e[k + 1] = 0.0
        } else {
            e[k + 1]  = -s
            w[k + 1] +=  s
            s = 1 / math.Sqrt(w[k + 1] * s)
            for i := k + 1; i < N; i++ {
                w[i] *= s
			}

            for i := k + 1; i < N; i++ {
                s = 0.0
                for j := k + 1; j < N; j++ {
                    if (j <= i) {
                        s += a[i][j] * w[j]
                    } else {
                        s += a[j][i] * w[j]
					}
                }
                v[i] = s
            }

            s = 0.0
            for i := k + 1; i < N; i++ {
                s += w[i] * v[i]
			}
            s /= 2.0
            for i := k + 1; i < N; i++ {
                v[i] -= s * w[i]
			}
            for i := k + 1; i < N; i++ {
                for j := k + 1; j < i + 1; j++ {
                    a[i][j] -= w[i] * v[j] + w[j] * v[i]
				}
			}
            // 次の行は固有ベクトルを求めないなら不要
            for i := k + 1; i < N; i++ {
                a[i][k] = w[i]
			}
        }
    }

    d[N - 2] = a[N - 2][N - 2]
    d[N - 1] = a[N - 1][N - 1]

    e[0]     = 0.0
    e[N - 1] = a[N - 1][N - 2]

    // 次の行は固有ベクトルを求めないなら不要
	for k := N - 1; k >= 0; k-- {
        var w = []float64 {0.0 ,0.0 ,0.0 ,0.0}
        if (k < N - 2) {
            for i := k + 1; i < N; i++ {
                w[i] = a[i][k]
			}
            for i := k + 1; i < N; i++ {
                var s float64 = 0.0
                for j := k + 1; j < N; j++ {
                    s += a[i][j] * w[j]
				}
                v[i] = s
            }
            for i := k + 1; i < N; i++ {
                for j := k + 1; j < N; j++ {
                    a[i][j] -= v[i] * w[j]
				}
			}
        }
        for i := 0; i < N; i++ {
            a[i][k] = 0.0
		}
        a[k][k] = 1.0
    }

}

// QR分解
func decomp(a *[N][N]float64, d []float64, e []float64) {
    e[0] = 1.0
    var h int = N - 1
    for (math.Fabs(e[h]) < 0.00000000001) {
		h--
	}
    for (h > 0) {
        e[0] = 0.0
        var l int = h - 1
        for (math.Fabs(e[l]) >= 0.00000000001) {
			l--
		}

        for j := 1; j < 100; j++ {
            var w float64 = (d[h - 1] - d[h]) / 2.0
            var s float64 = math.Sqrt(w * w + e[h] * e[h])
            if (w < 0.0) {
                s = -s
			}

            var x float64 = d[l] - d[h] + e[h] * e[h] / (w + s)
            var y float64 = e[l + 1]
            var z float64 = 0.0
            var t float64 = 0.0
            var u float64 = 0.0
            for k := l; k < h; k++ {
                if (math.Fabs(x) >= math.Fabs(y)) {
                    t = -y / x
                    u = 1 / math.Sqrt(t * t + 1.0)
                    s = t * u
                } else {
                    t = -x / y
                    s = 1 / math.Sqrt(t * t + 1.0)
                    if (t < 0) {
                        s = -s
					}
                    u = t * s
                }
                w = d[k] - d[k + 1]
                t = (w * s + 2 * u * e[k + 1]) * s
                d[k    ] = d[k    ] - t
                d[k + 1] = d[k + 1] + t
                e[k    ] = u * e[k] - s * z
                e[k + 1] = e[k + 1] * (u * u - s * s) + w * s * u

                // 次の行は固有ベクトルを求めないなら不要
                for i := 0; i < N; i++ {
                    x = a[k    ][i]
                    y = a[k + 1][i]
                    a[k    ][i] = u * x - s * y
                    a[k + 1][i] = s * x + u * y
                }

                if (k < N - 2) {
                    x = e[k + 1]
                    y = -s * e[k + 2]
                    z = y
                    e[k + 2] = u * e[k + 2]
                }
            }

            fmt.Printf("%3d\t", j)
            disp_vector(d)

            // 収束判定
            if (math.Fabs(e[h]) < 0.00000000001) {
				break
			}
        }

        e[0] = 1.0
        for (math.Fabs(e[h]) < 0.00000000001) {
			h--
		}
    }

    // 次の行は固有ベクトルを求めないなら不要
    for k := 0; k < N - 1; k++ {
        var l int = k
        for i := k + 1; i < N; i++ {
            if (d[i] > d[l]) {
                l = i
			}
		}

        var t float64 = d[k]
        d[k] = d[l]
        d[l] = t

        for i := 0; i < N; i++ {
            t       = a[k][i]
            a[k][i] = a[l][i]
            a[l][i] = t
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
    for row := 0; row < N; row++ {
        for col := 0; col < N; col++ {
            fmt.Printf("%14.10f\t", matrix[row][col])
        }
    	fmt.Println()
    }
}
