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

// 前進消去
forward_elimination(a,b)

WScript.StdOut.WriteLine("forward elimination")
WScript.StdOut.WriteLine("A")
disp_matrix(a)
WScript.StdOut.WriteLine("B")
disp_vector(b)
WScript.StdOut.WriteLine()

// 後退代入
backward_substitution(a,b)

WScript.StdOut.WriteLine("X")
disp_vector(b)
   
// 前進消去
function forward_elimination(a, b)
{
    for (pivot = 0; pivot < N; pivot++)
    {
        for (row = 0; row < N; row++)
        {
            if (row == pivot) continue

            var s = a[row][pivot] / a[pivot][pivot]
            for (col = pivot; col < N; col++)
                a[row][col] -= a[pivot][col]    * s
            b[row]          -= b[pivot]         * s
        }
    }
}
// 後退代入
function backward_substitution(a, b)
{
    for (pivot = 0; pivot < N; pivot++)
        b[pivot]  /= a[pivot][pivot]
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
// 状態を確認
function disp_progress(a, b)
{
    for (i = 0; i < N; i++) 
    {
        for (j = 0; j < N; j++) 
		    WScript.StdOut.Write(("              "    + a[i][j].toFixed(10)).slice(-14) + "\t")
	    WScript.StdOut.WriteLine(("              "    + b[i].toFixed(10)).slice(-14))
    }
	WScript.StdOut.WriteLine()
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
