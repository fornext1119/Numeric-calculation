var N = 4

// ヤコビ法で固有値を求める
main()

function main()
{
    var a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]]
    var v = [[1.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,1.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,1.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,1.0]]

    // ヤコビ法
    jacobi(a, v)

    WScript.StdOut.WriteLine()
    WScript.StdOut.WriteLine("eigenvalue")
    disp_eigenvalue(a)

    WScript.StdOut.WriteLine()
    WScript.StdOut.WriteLine("eigenvector")
    disp_eigenvector(v)
}


// ヤコビ法
function jacobi(a, v)
{
    for (var k = 1; k <= 100; k++)
    {
        // 最大値を探す
		var p = 0
		var q = 0
        var max_val = 0.0
        for (var i = 0; i < N; i++)
        {
            for (var j = i + 1; j < N; j++)
            {
                if (max_val < Math.abs(a[i][j]))
                {
                    max_val = Math.abs(a[i][j])
                    p = i
                    q = j
				}
			}
		}

        // θ を求める
        var t = 0.0
        if (Math.abs(a[p][p] - a[q][q]) < 0.00000000001)
        {
            // a_{pp} ＝ a_{qq} のとき、回転角ｔをπ/4にする
            t = Math.PI / 4.0
			if (a[p][p] < 0)
				t = -t
        }
        else
        {
            // a_{pp} ≠ a_{qq} のとき
            t = Math.atan(2.0 * a[p][q] / (a[p][p] - a[q][q])) / 2.0
        }

        // θ を使って 行列 U を作成し、A = U^t × A × U
        var c = Math.cos(t)
        var s = Math.sin(t)
        // U^t × A
        var t1 = 0.0
        var t2 = 0.0
        for (var i = 0; i < N; i++)
        {
            t1      =  a[p][i] * c + a[q][i] * s
            t2      = -a[p][i] * s + a[q][i] * c
            a[p][i] = t1
            a[q][i] = t2
            // 固有ベクトル
            t1      =  v[p][i] * c + v[q][i] * s
            t2      = -v[p][i] * s + v[q][i] * c
            v[p][i] = t1
            v[q][i] = t2
        }
        // A × U
        for (var i = 0; i < N; i++)
        {
            t1      =  a[i][p] * c + a[i][q] * s
            t2      = -a[i][p] * s + a[i][q] * c
            a[i][p] = t1
            a[i][q] = t2
        }

        // 対角要素を表示
		WScript.StdOut.Write(("   "           + k).slice( -3) + "\t")
        disp_eigenvalue(a)

        // 収束判定
    	if (max_val < 0.00000000001) break
    }
}

// 対角要素を表示
function disp_eigenvalue(a)
{
    for (var i = 0; i < N; i++)
        WScript.StdOut.Write(("              "    + a[i][i].toFixed(10)).slice(-14) + "\t")
    WScript.StdOut.WriteLine()
}
// 固有ベクトルを表示
function disp_eigenvector(matrix)
{
    for (var i = 0; i < N; i++)
    {
		var row = [0.0 ,0.0 ,0.0 ,0.0]
        for (var j = 0; j < N; j++)
            row[j] = matrix[i][j]
        normarize(row)
        disp_vector(row)
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
