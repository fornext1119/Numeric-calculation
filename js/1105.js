var N = 4

// ���R�r�@�ŌŗL�l�����߂�
main()

function main()
{
    var a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]]
    var v = [[1.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,1.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,1.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,1.0]]

    // ���R�r�@
    jacobi(a, v)

    WScript.StdOut.WriteLine()
    WScript.StdOut.WriteLine("eigenvalue")
    disp_eigenvalue(a)

    WScript.StdOut.WriteLine()
    WScript.StdOut.WriteLine("eigenvector")
    disp_eigenvector(v)
}


// ���R�r�@
function jacobi(a, v)
{
    for (var k = 1; k <= 100; k++)
    {
        // �ő�l��T��
		var p = 0
		var q = 0
        var max_val = 0.0
        for (var i = 0; i < N; i++)
        {
            for (var j = i + 1; j < N; j++)
            {
                if (max_val < Math.abs(a[i][j]))
                {
                    max_val = Math.abs(a[i][j])
                    p = i
                    q = j
				}
			}
		}

        // �� �����߂�
        var t = 0.0
        if (Math.abs(a[p][p] - a[q][q]) < 0.00000000001)
        {
            // a_{pp} �� a_{qq} �̂Ƃ��A��]�p������/4�ɂ���
            t = Math.PI / 4.0
			if (a[p][p] < 0)
				t = -t
        }
        else
        {
            // a_{pp} �� a_{qq} �̂Ƃ�
            t = Math.atan(2.0 * a[p][q] / (a[p][p] - a[q][q])) / 2.0
        }

        // �� ���g���� �s�� U ���쐬���AA = U^t �~ A �~ U
        var c = Math.cos(t)
        var s = Math.sin(t)
        // U^t �~ A
        var t1 = 0.0
        var t2 = 0.0
        for (var i = 0; i < N; i++)
        {
            t1      =  a[p][i] * c + a[q][i] * s
            t2      = -a[p][i] * s + a[q][i] * c
            a[p][i] = t1
            a[q][i] = t2
            // �ŗL�x�N�g��
            t1      =  v[p][i] * c + v[q][i] * s
            t2      = -v[p][i] * s + v[q][i] * c
            v[p][i] = t1
            v[q][i] = t2
        }
        // A �~ U
        for (var i = 0; i < N; i++)
        {
            t1      =  a[i][p] * c + a[i][q] * s
            t2      = -a[i][p] * s + a[i][q] * c
            a[i][p] = t1
            a[i][q] = t2
        }

        // �Ίp�v�f��\��
		WScript.StdOut.Write(("   "           + k).slice( -3) + "\t")
        disp_eigenvalue(a)

        // ��������
    	if (max_val < 0.00000000001) break
    }
}

// �Ίp�v�f��\��
function disp_eigenvalue(a)
{
    for (var i = 0; i < N; i++)
        WScript.StdOut.Write(("              "    + a[i][i].toFixed(10)).slice(-14) + "\t")
    WScript.StdOut.WriteLine()
}
// �ŗL�x�N�g����\��
function disp_eigenvector(matrix)
{
    for (var i = 0; i < N; i++)
    {
		var row = [0.0 ,0.0 ,0.0 ,0.0]
        for (var j = 0; j < N; j++)
            row[j] = matrix[i][j]
        normarize(row)
        disp_vector(row)
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
