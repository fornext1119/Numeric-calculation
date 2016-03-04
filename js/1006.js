var N = 4

var a = [[5,2,3,4],[2,10,6,7],[3,6,15,9],[4,7,9,20]] 
var b = [34,68,96,125]

WScript.StdOut.WriteLine("A")
disp_matrix(a)
WScript.StdOut.WriteLine("B")
disp_vector(b)
WScript.StdOut.WriteLine()

// 前進消去
forward_elimination(a,b)

WScript.StdOut.WriteLine("LL^T")
disp_matrix(a)

// Ly=b から y を求める (前進代入)
var y = [0,0,0,0]
forward_substitution(a,b,y)

WScript.StdOut.WriteLine("Y")
disp_vector(y)

// L^Tx=y から x を求める (後退代入)
var x = [0,0,0,0]
backward_substitution(a,y,x)

WScript.StdOut.WriteLine("X")
disp_vector(x)

// 前進消去
function forward_elimination(a, b)
{
    for (pivot = 0; pivot < N; pivot++)
    {
        var s = 0
        for (col = 0; col < pivot; col++)
            s += a[pivot][col] * a[pivot][col]
        // ここで根号の中が負の値になると計算できない！
        a[pivot][pivot] = Math.sqrt(a[pivot][pivot] - s)

        for (row = pivot + 1; row < N; row++)
        {
            s = 0
            for (col = 0; col < pivot; col++)
                s += a[row][col] * a[pivot][col]
            a[row][pivot] =  (a[row][pivot] - s) / a[pivot][pivot]
            a[pivot][row] =  a[row][pivot]
        } 
    }
}
// 前進代入
function forward_substitution(a, b, y)
{
    for (row = 0; row < N; row++)
    {
        for (col = 0; col < row; col++)
            b[row] -= a[row][col] * y[col]
        y[row] = b[row] / a[row][row]
    }
}
// 後退代入
function backward_substitution(a, y, x)
{
    for (row = N - 1; row >= 0; row--)
    {
        for (col = N - 1; col > row; col--)
            y[row] -= a[row][col] * x[col]
        x[row] = y[row] / a[row][row]
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
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
            WScript.StdOut.Write(("              "    + matrix[i][j].toFixed(10)).slice(-14) + "\t")
        WScript.StdOut.WriteLine()
    }
}
