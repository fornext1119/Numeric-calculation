var N = 4

// ベキ乗法で最大固有値を求める
main()

function main()
{
    var a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]]
    var x =  [1.0 ,0.0 ,0.0 ,0.0]

    // ベキ乗法
    var lambda = power(a, x)

    WScript.StdOut.WriteLine()
    WScript.StdOut.WriteLine("eigenvalue")
    WScript.StdOut.WriteLine(("              "    + lambda.toFixed(10)).slice(-14))

    WScript.StdOut.WriteLine("eigenvector")
    disp_vector(x)
}

// ベキ乗法
function power(a, x0)
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

        // 行列の積 x1 = A × x0
        var x1 = [0.0 ,0.0 ,0.0 ,0.0]
        for (var i = 0; i < N; i++)
            for (var j = 0; j < N; j++)
                x1[i] += a[i][j] * x0[j]

        // 内積
        var p0 = 0.0
        var p1 = 0.0
        for (var i = 0; i < N; i++)
        {
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        }
        // 固有値
        lambda = p0 / p1

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
