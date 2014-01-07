// データ点の数
var N = 7

var x = []
var y = []

// 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
for (var i = 0; i < N; i++)
{
    var d = i * 1.5 - 4.5
    x[i] = d
    y[i] = f(d)
}

// 0.5刻みで 与えられていない値を補間
for (var i = 0; i <= 18; i++)
{
    var d1  = i * 0.5 - 4.5
    var d2 = f(d1)
    var d3 = lagrange(d1, x, y)

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

// Lagrange (ラグランジュ) 補間
function lagrange(d, x, y)
{
    var sum = 0;
    for (var i = 0; i < N; i++)
	{
        prod = y[i]
        for (var j = 0; j < N; j++) 
		{
            if (j != i)
                prod *= (d - x[j]) / (x[i] - x[j])
        }
        sum += prod
    }
    return sum
}
