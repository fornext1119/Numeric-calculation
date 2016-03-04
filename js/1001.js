var N = 4

var a = [[9,2,1,1],[2,8,-2,1],[-1,-2,7,-2],[1,-1,-2,6]] 
var b = [20,16,8,17]
var c = [0,0,0,0]

// ���R�r�̔����@
jacobi(a,b,c)

WScript.StdOut.WriteLine("X")
disp_vector(c)

// ���R�r�̔����@
function jacobi(a, b, x0)
{
    while (true)
    {
        x1 = []
        var finish = true
        for (i = 0; i < N; i++)
        {
            x1[i] = 0
            for (j = 0; j < N; j++)
                if (j != i)
                    x1[i] += a[i][j] * x0[j]

            x1[i] = (b[i] - x1[i]) / a[i][i]
            if (Math.abs(x1[i] - x0[i]) > 0.0000000001) finish = false
        }
        for (i = 0; i < N; i++)
            x0[i] = x1[i]
        if (finish) return

		disp_vector(x0)
    }
}

// �P�����z���\��
function disp_vector(row) 
{
    for (var i = 0; i < N; i++)
        WScript.StdOut.Write(("              "    + row[i].toFixed(10)).slice(-14) + "\t")
    WScript.StdOut.WriteLine()
}
