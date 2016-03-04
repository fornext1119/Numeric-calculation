var N = 4

// ハウスホルダー変換とQR分解で固有値を求める
main()

function main()
{
    var a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]]
    var d =  [1.0 ,0.0 ,0.0 ,0.0]
    var e =  [1.0 ,0.0 ,0.0 ,0.0]

    // ハウスホルダー変換
    tridiagonalize(a, d, e)

    // QR分解
    decomp(a, d, e)

    WScript.StdOut.WriteLine()
    WScript.StdOut.WriteLine("eigenvalue")
    disp_vector(d)

    WScript.StdOut.WriteLine()
    WScript.StdOut.WriteLine("eigenvector")
    disp_matrix(a)
}


// ハウスホルダー変換
function tridiagonalize(a, d, e)
{
    var v =  [0.0 ,0.0 ,0.0 ,0.0]

    for (var k = 0; k < N - 2; k++)
    {
        var w = [0.0 ,0.0 ,0.0 ,0.0]
        d[k] = a[k][k]

        var t = 0.0
        for (var i = k + 1; i < N; i++)
        {
            w[i] =  a[i][k]
            t    += w[i] * w[i]
        }
        var s = Math.sqrt(t)
        if (w[k + 1] < 0)
            s = -s

        if (Math.abs(s) < 0.00000000001)
            e[k + 1] = 0.0
        else
        {
            e[k + 1]  = -s
            w[k + 1] +=  s
            s = 1 / Math.sqrt(w[k + 1] * s)
            for (var i = k + 1; i < N; i++)
                w[i] *= s

            for (var i = k + 1; i < N; i++)
            {
                s = 0.0
                for (var j = k + 1; j < N; j++)
                {
                    if (j <= i)
                        s += a[i][j] * w[j]
                    else
                        s += a[j][i] * w[j]
                }
                v[i] = s
            }

            s = 0.0
            for (var i = k + 1; i < N; i++)
                s += w[i] * v[i]
            s /= 2.0
            for (var i = k + 1; i < N; i++)
                v[i] -= s * w[i]
            for (var i = k + 1; i < N; i++)
                for (var j = k + 1; j <= i; j++)
                    a[i][j] -= w[i] * v[j] + w[j] * v[i]
            // 次の行は固有ベクトルを求めないなら不要
            for (var i = k + 1; i < N; i++)
                a[i][k] = w[i]
        }
    }

    d[N - 2] = a[N - 2][N - 2]
    d[N - 1] = a[N - 1][N - 1]

    e[0]     = 0.0
    e[N - 1] = a[N - 1][N - 2]

    // 次の行は固有ベクトルを求めないなら不要
    for (var k = N - 1; k >= 0; k--)
    {
        var w = [0.0 ,0.0 ,0.0 ,0.0]
        if (k < N - 2)
        {
            for (var i = k + 1; i < N; i++)
                w[i] = a[i][k]
            for (var i = k + 1; i < N; i++)
            {
                var s = 0.0
                for (var j = k + 1; j < N; j++)
                    s += a[i][j] * w[j]
                v[i] = s
            }
            for (var i = k + 1; i < N; i++)
                for (var j = k + 1; j < N; j++)
                    a[i][j] -= v[i] * w[j]
        }
        for (var i = 0; i < N; i++)
            a[i][k] = 0.0
        a[k][k] = 1.0
    }
}

// QR分解
function decomp(a, d, e)
{
    e[0] = 1.0
    var h = N - 1
    while (Math.abs(e[h]) < 0.00000000001) h--

    while (h > 0)
    {
        e[0] = 0.0
        var l = h - 1
        while (Math.abs(e[l]) >= 0.00000000001) l--

        for (var j = 1; j <= 100; j++)
        {
            var w = (d[h - 1] - d[h]) / 2.0
            var s = Math.sqrt(w * w + e[h] * e[h])
            if (w < 0.0)
                s = -s

            var x = d[l] - d[h] + e[h] * e[h] / (w + s)
            var y = e[l + 1]
            var z = 0.0
            var t = 0.0
            var u = 0.0
            for (var k = l; k < h; k++)
            {
                if (Math.abs(x) >= Math.abs(y))
                {
                    t = -y / x
                    u = 1 / Math.sqrt(t * t + 1.0)
                    s = t * u
                }
                else
                {
                    t = -x / y
                    s = 1 / Math.sqrt(t * t + 1.0)
                    if (t < 0)
                        s = -s
                    u = t * s
                }
                w = d[k] - d[k + 1]
                t = (w * s + 2 * u * e[k + 1]) * s
                d[k    ] = d[k    ] - t
                d[k + 1] = d[k + 1] + t
                e[k    ] = u * e[k] - s * z
                e[k + 1] = e[k + 1] * (u * u - s * s) + w * s * u

                // 次の行は固有ベクトルを求めないなら不要
                for (var i = 0; i < N; i++)
                {
                    x = a[k    ][i]
                    y = a[k + 1][i]
                    a[k    ][i] = u * x - s * y
                    a[k + 1][i] = s * x + u * y
                }

                if (k < N - 2)
                {
                    x = e[k + 1]
                    y = -s * e[k + 2]
                    z = y
                    e[k + 2] = u * e[k + 2]
                }
            }

            WScript.StdOut.Write(("   "           + j).slice( -3) + "\t")
            disp_vector(d)

            // 収束判定
            if (Math.abs(e[h]) < 0.00000000001) break
        }

        e[0] = 1.0
        while (Math.abs(e[h]) < 0.00000000001) h--
    }

    // 次の行は固有ベクトルを求めないなら不要
    for (var k = 0; k < N - 1; k++)
    {
        var l = k
        for (var i = k + 1; i < N; i++)
            if (d[i] > d[l])
                l = i

        var t = d[k]
        d[k] = d[l]
        d[l] = t

        for (var i = 0; i < N; i++)
        {
            t       = a[k][i]
            a[k][i] = a[l][i]
            a[l][i] = t
        }
    }
}

// １次元配列を表示
function disp_vector(row)
{
    for (var i = 0; i < N; i++)
        WScript.StdOut.Write(("              "    + row[i].toFixed(10)).slice(-14) + "\t")
    WScript.StdOut.WriteLine()
}
// ２次元配列を表示
function disp_matrix(matrix)
{
    for (var row = 0; row < N; row++)
    {
        for (var col = 0; col < N; col++)
            WScript.StdOut.Write(("              "    + matrix[row][col].toFixed(10)).slice(-14) + "\t")
        WScript.StdOut.WriteLine()
    }
}
