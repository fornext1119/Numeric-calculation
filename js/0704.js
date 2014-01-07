// データ点の数
var N   =  7
var Nx2 = 14

var x  = []
var y  = []
var yd = []

// 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
for (var i = 0; i < N; i++)
{
    var d1 = i * 1.5 - 4.5
    x[i]   = d1
    y[i]   = f(d1)
    yd[i]  = fd(d1)
}

// 差分商の表を作る
var z = []
var d = []
d[0]  = []
for (var i = 0; i < Nx2; i++)
{
    var j   = parseInt(i / 2)
    z[i]    = x[j]
    d[0][i] = y[j]
}
for (var i = 1; i < Nx2; i++)
{
	d[i] = []
    for (var j = 0; j < Nx2 - i; j++)
    {
        if (i == 1 && j % 2 == 0)
            d[i][j] = yd[parseInt(j / 2)]
        else
            d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (z[j+i] - z[j])
    }
}

// ｎ階差分商
var a = []
for (var j = 0; j < Nx2; j++)
    a[j] = d[j][0]
// 0.5刻みで 与えられていない値を補間
for (var i = 0; i <= 18; i++)
{
    var d1 = i * 0.5 - 4.5
    var d2 = f(d1)
    var d3 = hermite(d1, z, a)

    // 元の関数と比較
    WScript.StdOut.Write(("     "    + d1.toFixed(2)       ).slice(-5) + "\t")
    WScript.StdOut.Write(("        " + d2.toFixed(5)       ).slice(-8) + "\t")
    WScript.StdOut.Write(("        " + d3.toFixed(5)       ).slice(-8) + "\t")
    WScript.StdOut.Write(("        " + (d2 - d3).toFixed(5)).slice(-8) + "\n")
}

// 元の関数
function f(x) 
{
    return x - Math.pow(x,3) / (3 * 2) + Math.pow(x,5) / (5 * 4 * 3 * 2)
}
// 導関数
function fd(x)
{
    return 1 - Math.pow(x,2) / 2 + Math.pow(x,4) / (4 * 3 * 2)
}

// Hermite (エルミート) 補間
function hermite(d, z, a) {
    var sum = a[0]
    for (var i = 1; i < Nx2; i++)
    {
        var prod = a[i]
        for (var j = 0; j < i; j++)
            prod *= (d - z[j])
        sum += prod
    }

    return sum
}
