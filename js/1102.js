var N = 4

// �t�x�L��@�ōŏ��ŗL�l�����߂�
main()

function main()
{
	var a = [[5.0, 4.0, 1.0, 1.0],
	         [4.0, 5.0, 1.0, 1.0],
	         [1.0, 1.0, 4.0, 2.0],
	         [1.0, 1.0, 2.0, 4.0]]
	var x =  [1.0 ,0.0 ,0.0 ,0.0]

	// LU����
	forward_elimination(a)

	// �t�x�L��@
	var lambda = inverse(a, x)

	WScript.StdOut.WriteLine()
	WScript.StdOut.WriteLine("eigenvalue")
    WScript.StdOut.WriteLine(("              "    + lambda.toFixed(10)).slice(-14))

	WScript.StdOut.WriteLine("eigenvector")
	disp_vector(x)
}

// �t�x�L��@
function inverse(a, x0)
{
    var lambda = 0.0

    // ���K�� (�x�N�g�� x0 �̒������P�ɂ���)
    normarize(x0)
	var e0 = 0.0
    for (var i = 0; i < N; i++)
        e0 += x0[i]

    for (var k = 1; k <= 200; k++)
	{
        // �P�����z���\��
		WScript.StdOut.Write(("   "           + k).slice( -3) + "\t")
        disp_vector(x0)

		// Ly=b ���� y �����߂� (�O�i���)
		var b = [0,0,0,0]
		var y = [0,0,0,0]
        for (var i = 0; i < N; i++)
            b[i] = x0[i]
		forward_substitution(a,y,b)

		// Ux=y ���� x �����߂� (��ޑ��)
		var x1 = [0,0,0,0]
		backward_substitution(a,x1,y)

        // ����
        var p0 = 0.0
        var p1 = 0.0
        for (var i = 0; i < N; i++)
		{
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        }
        // �ŗL�l
        lambda = p1 / p0

    	// ���K�� (�x�N�g�� x1 �̒������P�ɂ���)
	    normarize(x1)
        // ��������
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

// �O�i����
function forward_elimination(a)
{
    for (var pivot = 0; pivot < N - 1; pivot++)
    {
        for (var row = pivot + 1; row < N; row++)
        {
            var s = a[row][pivot] / a[pivot][pivot]
            for (var col = pivot; col < N; col++)
                a[row][col] -= a[pivot][col] * s // ���ꂪ ��O�p�s��
            a[row][pivot] = s                    // ���ꂪ ���O�p�s��
        }
    }
}
// �O�i���
function forward_substitution(a, y, b)
{
    for (var row = 0; row < N; row++)
    {
        for (var col = 0; col < row; col++)
            b[row] -= a[row][col] * y[col]
        y[row] = b[row]
    }
}
// ��ޑ��
function backward_substitution(a, x, y)
{
    for (var row = N - 1; row >= 0; row--)
    {
        for (var col = N - 1; col > row; col--)
            y[row] -= a[row][col] * x[col]
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
// ���K�� (�x�N�g���̒������P�ɂ���)
function normarize(x)
{
    var s = 0.0

    for (var i = 0; i < N; i++)
        s += x[i] * x[i]
    s = Math.sqrt(s)

    for (var i = 0; i < N; i++)
        x[i] /= s
}
