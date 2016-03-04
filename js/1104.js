var N = 4

// QR分解で固有値を求める
main()

function main()
{
    var a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]]
    var q = [[0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0]]
    var r = [[0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0]]

    for (var k = 1; k <= 200; k++)
    {
        // QR分解
        decomp(a, q, r)
        // 行列の積
        multiply(r, q, a)
        // 対角要素を表示
        WScript.StdOut.Write(("   "           + k).slice( -3) + "\t")
        disp_eigenvalue(a)

        // 収束判定
        var e = 0.0
        for (var i = 1; i < N; i++)
            for (var j = 0; j < i; j++)
                e += Math.abs(a[i][j])
        if (e < 0.00000000001) break
    }

    WScript.StdOut.WriteLine()
    WScript.StdOut.WriteLine("eigenvalue")
    disp_eigenvalue(a)
}
// QR分解
function decomp(a, q, r)
{
    var x = [0.0 ,0.0 ,0.0 ,0.0]

    for (var k = 0; k < N; k++)
    {
        for (var i = 0; i < N; i++)
            x[i] = a[i][k]

        for (var j = 0; j < k; j++)
        {
            var t = 0.0
            for (var i = 0; i < N; i++)
                t += a[i][k] * q[i][j]
            r[j][k] = t
            r[k][j] = 0.0
            for (var i = 0; i < N; i++)
                x[i] -= t * q[i][j]
        }

        var s = 0.0
        for (var i = 0; i < N; i++)
            s += x[i] * x[i]
        r[k][k] = Math.sqrt(s)
        for (var i = 0; i < N; i++)
            q[i][k] = x[i] / r[k][k]
    }
}
// 行列の積
function multiply(a, b, c)
{
    for (var i = 0; i < N; i++)
    {
        for (var j = 0; j < N; j++)
        {
            var s = 0.0
            for (var k = 0; k < N; k++)
                s += a[i][k] * b[k][j]
            c[i][j] = s
        }
    }
}
// 対角要素を表示
function disp_eigenvalue(a)
{
    for (var i = 0; i < N; i++)
        WScript.StdOut.Write(("              "    + a[i][i].toFixed(10)).slice(-14) + "\t")
    WScript.StdOut.WriteLine()
}
