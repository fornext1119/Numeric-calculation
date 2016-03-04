var N = 4

// �x�L��@�ōő�ŗL�l�����߂�
main()

function main()
{
    var a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]]
    var x =  [1.0 ,0.0 ,0.0 ,0.0]

    // �x�L��@
    var lambda = power(a, x)

    WScript.StdOut.WriteLine()
    WScript.StdOut.WriteLine("eigenvalue")
    WScript.StdOut.WriteLine(("              "    + lambda.toFixed(10)).slice(-14))

    WScript.StdOut.WriteLine("eigenvector")
    disp_vector(x)
}

// �x�L��@
function power(a, x0)
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

        // �s��̐� x1 = A �~ x0
        var x1 = [0.0 ,0.0 ,0.0 ,0.0]
        for (var i = 0; i < N; i++)
            for (var j = 0; j < N; j++)
                x1[i] += a[i][j] * x0[j]

        // ����
        var p0 = 0.0
        var p1 = 0.0
        for (var i = 0; i < N; i++)
        {
            p0 += x1[i] * x1[i]
            p1 += x1[i] * x0[i]
        }
        // �ŗL�l
        lambda = p0 / p1

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
