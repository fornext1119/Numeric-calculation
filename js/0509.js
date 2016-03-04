for (var x = -10; x <= 10; x++)
{
    // ����̑o�Ȑ��]���֐�
    var d1 = myCosh(x, 1, 1.0, 1.0, 1.0);
    // �W���̑o�Ȑ��]���֐��͂Ȃ�
    var d2 = (Math.exp(x) + Math.exp(-x)) / 2;
    // �W���֐��Ƃ̍���
    WScript.StdOut.Write(("   "               + x                    ).slice( -3) + " : ");
    WScript.StdOut.Write(("                 " + d1.toFixed(10)       ).slice(-17) + " - ");
    WScript.StdOut.Write(("                 " + d2.toFixed(10)       ).slice(-17) + " = ");
    WScript.StdOut.Write(("             "     + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
}

// ����̑o�Ȑ��]���֐�
function myCosh(x, n, numerator, denominator, y) 
{
    var m       = 2 * n;
    denominator = denominator * m * (m - 1);
    numerator   = numerator   * x * x;
    var a       = numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (Math.abs(a) <= 0.00000000001) 
        return y;
    else
        return y + myCosh(x, ++n, numerator, denominator, a);
}
