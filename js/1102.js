var N = 4

// 逆ベキ乗法で最小固有値を求める
main()

function main()
{
	var a = [[5.0, 4.0, 1.0, 1.0],
	         [4.0, 5.0, 1.0, 1.0],
	         [1.0, 1.0, 4.0, 2.0],
	         [1.0, 1.0, 2.0, 4.0]]
	var x =  [1.0 ,0.0 ,0.0 ,0.0]

	// LU分解
	forward_elimination(a)

	// 逆ベキ乗法
	var lambda = inverse(a, x)

	WScript.StdOut.WriteLine()
	WScript.StdOut.WriteLine("eigenvalue")
    WScript.StdOut.WriteLine(("              "    + lambda.toFixed(10)).slice(-14))

	WScript.StdOut.WriteLine("eigenvector")
	disp_vector(x)
}

// 逆ベキ乗法
function inverse(a, x0)
{
    var lambda = 0.0

    // 正規化 (ベクトル x0 の長さを１にする)
    normarize(x0)
	var e0 = 0.0
    for (var i = 0; i < N; i++)
        e0 += x0[i]

    for (var k = 1; k <= 200; k++)
	{
        // １次元配列を表示
		WScript.StdOut.Write(("   "           + k).slice( -3) + "\t")
        disp_vector(x0)

		// Ly=b から y を求める (前進代入)
		var b = [0,0,0,0]
		var y = [0,0,0,0]
        for (var i = 0; i < N; i++)
            b[i] = x0[i]
		forward_substitution(a,y,b)

		// Ux=y から x を求める (後退代入)
		var x1 = [0,0,0,0]
		backward_substitution(a,x1,y)

        // 内積
        var p0 = 0.0
        var p1 = 0.0
        for (var i = 0; i < N; i++)
		{
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        }
        // 固有値
        lambda = p1 / p0

    	// 正規化 (ベクトル x1 の長さを１にする)
	    normarize(x1)
        // 収束判定
		var e1 = 0.0
	    for (var i = 0; i < N; i++)
	        e1 += x1[i]
        if (Math.abs(e0 - e1) < 0.00000000001) break

        for (var i = 0; i < N; i++)
            x0[i] = x1[i]
        e0 = e1
    }
	return lambda
}

// 前進消去
function forward_elimination(a)
{
    for (var pivot = 0; pivot < N - 1; pivot++)
    {
        for (var row = pivot + 1; row < N; row++)
        {
            var s = a[row][pivot] / a[pivot][pivot]
            for (var col = pivot; col < N; col++)
                a[row][col] -= a[pivot][col] * s // これが 上三角行列
            a[row][pivot] = s                    // これが 下三角行列
        }
    }
}
// 前進代入
function forward_substitution(a, y, b)
{
    for (var row = 0; row < N; row++)
    {
        for (var col = 0; col < row; col++)
            b[row] -= a[row][col] * y[col]
        y[row] = b[row]
    }
}
// 後退代入
function backward_substitution(a, x, y)
{
    for (var row = N - 1; row >= 0; row--)
    {
        for (var col = N - 1; col > row; col--)
            y[row] -= a[row][col] * x[col]
        x[row] = y[row] / a[row][row]
    }
}
// １次元配列を表示
function disp_vector(row)
{
    for (var i = 0; i < N; i++)
        WScript.StdOut.Write(("              "    + row[i].toFixed(10)).slice(-14) + "\t")
    WScript.StdOut.WriteLine()
}
// 正規化 (ベクトルの長さを１にする)
function normarize(x)
{
    var s = 0.0

    for (var i = 0; i < N; i++)
        s += x[i] * x[i]
    s = Math.sqrt(s)

    for (var i = 0; i < N; i++)
        x[i] /= s
}
