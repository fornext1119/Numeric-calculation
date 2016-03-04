var N = 4

var a = [[-1,-2,7,-2],[1,-1,-2,6],[9,2,1,1],[2,8,-2,1]] 
var b = [8,17,20,16]

// ピボット選択
pivoting(a,b)

WScript.StdOut.WriteLine("pivoting")
WScript.StdOut.WriteLine("A")
disp_matrix(a)
WScript.StdOut.WriteLine("B")
disp_vector(b)
WScript.StdOut.WriteLine()

// LU分解
// 前進消去
forward_elimination(a,b)

WScript.StdOut.WriteLine("LU")
disp_matrix(a)

// Ly=b から y を求める (前進代入)
var y = [0,0,0,0]
forward_substitution(a,b,y)

WScript.StdOut.WriteLine("Y")
disp_vector(y)

// Ux=y から x を求める (後退代入)
var x = [0,0,0,0]
backward_substitution(a,y,x)

WScript.StdOut.WriteLine("X")
disp_vector(x)

// 前進消去
function forward_elimination(a, b)
{
    for (pivot = 0; pivot < N - 1; pivot++)
    {
        for (row = pivot + 1; row < N; row++)
        {
            var s = a[row][pivot] / a[pivot][pivot]
            for (col = pivot; col < N; col++)
                a[row][col] -= a[pivot][col] * s // これが 上三角行列
            a[row][pivot] = s                    // これが 下三角行列
            // b[row]    -= b[pivot] * s         // この値は変更しない
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
        y[row] = b[row]
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
// ピボット選択
function pivoting(a, b)
{
    for (pivot = 0; pivot < N; pivot++)
    {
        // 各列で 一番値が大きい行を 探す
        var max_row =   pivot
        var max_val =   0
        for (row = pivot; row < N; row++)
        {
            if (Math.abs(a[row][pivot]) > max_val)
            {
                // 一番値が大きい行
                max_val =   Math.abs(a[row][pivot])
                max_row =   row
            }
        }

        // 一番値が大きい行と入れ替え
        if (max_row != pivot)
        {
            var tmp
            for (col = 0; col < N; col++)
            {
                tmp             =   a[max_row][col]
                a[max_row][col] =   a[pivot][col]
                a[pivot][col]   =   tmp
            }
            tmp         =   b[max_row]
            b[max_row]  =   b[pivot]
            b[pivot]    =   tmp
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
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
            WScript.StdOut.Write(("              "    + matrix[i][j].toFixed(10)).slice(-14) + "\t")
        WScript.StdOut.WriteLine()
    }
}
