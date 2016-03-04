// データ点の数
var N = 7

var x = []
var y = []

// 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
for (var i = 0; i < N; i++)
{
    var d1 = i * 1.5 - 4.5
    x[i]   = d1
    y[i]   = f(d1)
}

// ３項方程式の係数の表を作る
var a = []
var b = []
var c = []
var d = []
for (var i = 1; i < N - 1; i++)
{
    a[i] =         x[i]   - x[i-1]
    b[i] = 2.0 *  (x[i+1] - x[i-1])
    c[i] =         x[i+1] - x[i]
    d[i] = 6.0 * ((y[i+1] - y[i]) / (x[i+1] - x[i]) - (y[i] - y[i-1]) / (x[i] - x[i-1]))
}
// ３項方程式を解く (ト－マス法)
var g = []
var s = []
g[1] = b[1]
s[1] = d[1]
for (var i = 2; i < N - 1; i++)
{
    g[i] = b[i] - a[i] * c[i-1] / g[i-1]
    s[i] = d[i] - a[i] * s[i-1] / g[i-1]
}
var z  = []
z[0]   = 0
z[N-1] = 0
z[N-2] = s[N-2] / g[N-2]
for (var i = N - 3; i >= 1; i--)
    z[i] = (s[i] - c[i] * z[i+1]) / g[i]

// 0.5刻みで 与えられていない値を補間
for (var i = 0; i <= 18; i++)
{
    var d1 = i * 0.5 - 4.5
    var d2 = f(d1)
    var d3 = spline(d1, x, y, z)

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

// Spline (スプライン) 補間
function spline(d, x, y, z) 
{
    // 補間関数値がどの区間にあるか
    var k = -1
    for (var i = 1; i < N; i++) 
	{
        if (d <= x[i]) 
		{
            k = i - 1
            break
        }
    }
    if (k < 0) k = N - 1

    var d1 = x[k+1] - d
    var d2 = d      - x[k]
    var d3 = x[k+1] - x[k]
    return  (z[k] * Math.pow(d1,3) + z[k+1] * Math.pow(d2,3)) / (6.0 * d3)
          + (y[k]   / d3 - z[k]   * d3 / 6.0) * d1
          + (y[k+1] / d3 - z[k+1] * d3 / 6.0) * d2
}
