var N = 4

// QR�����ŌŗL�l�����߂�
main()

function main()
{
    var a = [[5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]]
    var q = [[0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0]]
    var r = [[0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0],
             [0.0 ,0.0 ,0.0 ,0.0]]

    for (var k = 1; k <= 200; k++)
    {
        // QR����
        decomp(a, q, r)
        // �s��̐�
        multiply(r, q, a)
        // �Ίp�v�f��\��
        WScript.StdOut.Write(("   "           + k).slice( -3) + "\t")
        disp_eigenvalue(a)

        // ��������
        var e = 0.0
        for (var i = 1; i < N; i++)
            for (var j = 0; j < i; j++)
                e += Math.abs(a[i][j])
        if (e < 0.00000000001) break
    }

    WScript.StdOut.WriteLine()
    WScript.StdOut.WriteLine("eigenvalue")
    disp_eigenvalue(a)
}
// QR����
function decomp(a, q, r)
{
    var x = [0.0 ,0.0 ,0.0 ,0.0]

    for (var k = 0; k < N; k++)
    {
        for (var i = 0; i < N; i++)
            x[i] = a[i][k]

        for (var j = 0; j < k; j++)
        {
            var t = 0.0
            for (var i = 0; i < N; i++)
                t += a[i][k] * q[i][j]
            r[j][k] = t
            r[k][j] = 0.0
            for (var i = 0; i < N; i++)
                x[i] -= t * q[i][j]
        }

        var s = 0.0
        for (var i = 0; i < N; i++)
            s += x[i] * x[i]
        r[k][k] = Math.sqrt(s)
        for (var i = 0; i < N; i++)
            q[i][k] = x[i] / r[k][k]
    }
}
// �s��̐�
function multiply(a, b, c)
{
    for (var i = 0; i < N; i++)
    {
        for (var j = 0; j < N; j++)
        {
            var s = 0.0
            for (var k = 0; k < N; k++)
                s += a[i][k] * b[k][j]
            c[i][j] = s
        }
    }
}
// �Ίp�v�f��\��
function disp_eigenvalue(a)
{
    for (var i = 0; i < N; i++)
        WScript.StdOut.Write(("              "    + a[i][i].toFixed(10)).slice(-14) + "\t")
    WScript.StdOut.WriteLine()
}
