for (var degree = 0; degree <= 360; degree += 15)
{
    if (degree % 30 == 0 || degree % 45 == 0)
    {
        var radian = degree * Math.PI / 180.0;
        // ����̗]���֐�
        var d1     = myCos(radian, 1, false, 1.0, 1.0, 1.0);
        // �W���̗]���֐�
        var d2     = Math.cos(radian);
        // �W���֐��Ƃ̍���
        WScript.StdOut.Write(("   "           + degree               ).slice( -3) + " : ");
        WScript.StdOut.Write(("             " + d1.toFixed(10)       ).slice(-13) + " - ");
        WScript.StdOut.Write(("             " + d2.toFixed(10)       ).slice(-13) + " = ");
        WScript.StdOut.Write(("             " + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
    }
}

// ����̗]���֐�
function myCos(x, n, nega, numerator, denominator, y)
{
    var m       = 2 * n;
    denominator = denominator * m * (m - 1);
    numerator   = numerator * x * x;
    var a       = numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (a <= 0.00000000001)
        return y;
    else
        return y + myCos(x, ++n, !nega, numerator, denominator, nega ? a : -a);
}
