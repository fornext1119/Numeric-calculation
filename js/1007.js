var N = 4

var a = [[5,2,3,4],[2,10,6,7],[3,6,15,9],[4,7,9,20]] 
var b = [34,68,96,125]

WScript.StdOut.WriteLine("A")
disp_matrix(a)
WScript.StdOut.WriteLine("B")
disp_vector(b)
WScript.StdOut.WriteLine()

// �O�i����
forward_elimination(a,b)

WScript.StdOut.WriteLine("LDL^T")
disp_matrix(a)

// Ly=b ���� y �����߂� (�O�i���)
var y = [0,0,0,0]
forward_substitution(a,b,y)

WScript.StdOut.WriteLine("Y")
disp_vector(y)

// DL^Tx=y ���� x �����߂� (��ޑ��)
var x = [0,0,0,0]
backward_substitution(a,y,x)

WScript.StdOut.WriteLine("X")
disp_vector(x)

// �O�i����
function forward_elimination(a, b)
{
    for (pivot = 0; pivot < N; pivot++)
    {
        var s

        // pivot < k �̏ꍇ
        for (col = 0; col < pivot; col++)
        {
            s = a[pivot][col]
            for (k = 0; k < col; k++)
                s -= a[pivot][k] * a[col][k] * a[k][k]
            a[pivot][col] = s / a[col][col]
            a[col][pivot] = a[pivot][col]
        }
 
        // pivot == k �̏ꍇ
        s = a[pivot][pivot]
        for (k = 0; k < pivot; k++)
            s -= a[pivot][k] * a[pivot][k] * a[k][k]
        a[pivot][pivot] = s
    }
}
// �O�i���
function forward_substitution(a, b, y)
{
    for (row = 0; row < N; row++)
    {
        for (col = 0; col < row; col++)
            b[row] -= a[row][col] * y[col]
        y[row] = b[row]
    }
}
// ��ޑ��
function backward_substitution(a, y, x)
{
    for (row = N - 1; row >= 0; row--)
    {
        for (col = N - 1; col > row; col--)
            y[row] -= a[row][col] * a[row][row] * x[col]
        x[row] = y[row] / a[row][row]
    }
}
// �P�����z���\��
function disp_vector(row) 
{
    for (var i = 0; i < N; i++)
        WScript.StdOut.Write(("              "    + row[i].toFixed(10)).slice(-14) + "\t")
    WScript.StdOut.WriteLine()
}
// �Q�����z���\��
function disp_matrix(matrix)
{
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
            WScript.StdOut.Write(("              "    + matrix[i][j].toFixed(10)).slice(-14) + "\t")
        WScript.StdOut.WriteLine()
    }
}
