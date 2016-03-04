var N = 4

var a = [[9,2,1,1],[2,8,-2,1],[-1,-2,7,-2],[1,-1,-2,6]] 
var b = [20,16,8,17]
var c = [0,0,0,0]

// ガウス・ザイデル法
gauss(a,b,c)

WScript.StdOut.WriteLine("X")
disp_vector(c)

// ガウス・ザイデル法
function gauss(a, b, x0)
{
    while (true)
    {
        var finish = true
        for (i = 0; i < N; i++)
        {
            var x1 = 0
            for (j = 0; j < N; j++)
                if (j != i)
                    x1 += a[i][j] * x0[j]

            x1 = (b[i] - x1) / a[i][i]
            if (Math.abs(x1 - x0[i]) > 0.0000000001) finish = false
            x0[i] = x1
        }
        if (finish) return

		disp_vector(x0)
    }
}

// １次元配列を表示
function disp_vector(row) 
{
    for (var i = 0; i < N; i++)
        WScript.StdOut.Write(("              "    + row[i].toFixed(10)).slice(-14) + "\t")
    WScript.StdOut.WriteLine()
}
