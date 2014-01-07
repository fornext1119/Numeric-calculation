for (var degree = 0; degree <= 360; degree += 15)
{
    if (degree % 30 == 0 || degree % 45 == 0)
    {
        var radian = degree * Math.PI / 180.0;
        // ����̐����֐�
        var d1     = mySin(radian, 1, false, radian, 1.0, radian);
        // �W���̐����֐�
        var d2     = Math.sin(radian);
        // �W���֐��Ƃ̍���
        WScript.StdOut.Write(("   "           + degree               ).slice( -3) + " : ");
        WScript.StdOut.Write(("             " + d1.toFixed(10)       ).slice(-13) + " - ");
        WScript.StdOut.Write(("             " + d2.toFixed(10)       ).slice(-13) + " = ");
        WScript.StdOut.Write(("             " + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
    }
}

// ����̐����֐�
function mySin(x, n, nega, numerator, denominator, y)
{
    var m       = 2 * n;
    denominator = denominator * (m + 1) * m;
    numerator   = numerator * x * x;
    var a       = numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (a <= 0.00000000001)
        return y;
    else
        return y + mySin(x, ++n, !nega, numerator, denominator, nega ? a : -a);
}
