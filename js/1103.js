var N = 4

// LR分解で固有値を求める
main()

function main()
{
    var a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]]
    var l = [[0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0]]
    var u = [[0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0]]

    for (var k = 1; k <= 200; k++)
    {
        // LU分解
        decomp(a, l, u)
        // 行列の積
        multiply(u, l, a)
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
// LU分解
function decomp(a, l, u)
{
    for (var i = 0; i < N; i++)
    {
        for (var j = 0; j < N; j++)
        {
            l[i][j] = 0.0
            u[i][j] = 0.0
        }
    }

    l[0][0] = 1.0
    for (var j = 0; j < N; j++)
        u[0][j] = a[0][j]

    for (var i = 1; i < N; i++)
    {
        u[i][0] = 0.0
        l[0][i] = 0.0
        l[i][0] = a[i][0] / u[0][0]
    }
    for (var i = 1; i < N; i++)
    {
        l[i][i] = 1.0
        var t = a[i][i]
        for (var k = 0; k <= i; k++)
            t -= l[i][k] * u[k][i]
        u[i][i] = t
        for (var j = i + 1; j < N; j++)
        {
            u[j][i] = 0.0
            l[i][j] = 0.0
            t       = a[j][i]
            for (var k = 0; k <= i; k++)
                t -= l[j][k] * u[k][i]
            l[j][i] = t / u[i][i]
            t       = a[i][j]
            for (var k = 0; k <= i; k++)
                t -= l[i][k] * u[k][j]
            u[i][j] = t
        }
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
