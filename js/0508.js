for (var x = -10; x <= 10; x++)
{
    // ����̑o�Ȑ������֐�
    var d1 = mySinh(x, 1, x, 1.0, x);
    // �W���̑o�Ȑ������֐��͂Ȃ�
    var d2 = (Math.exp(x) - Math.exp(-x)) / 2;
    // �W���֐��Ƃ̍���
    WScript.StdOut.Write(("   "               + x                    ).slice( -3) + " : ");
    WScript.StdOut.Write(("                 " + d1.toFixed(10)       ).slice(-17) + " - ");
    WScript.StdOut.Write(("                 " + d2.toFixed(10)       ).slice(-17) + " = ");
    WScript.StdOut.Write(("             "     + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
}

// ����̑o�Ȑ������֐�
function mySinh(x, n, numerator, denominator, y) 
{
    var m       = 2 * n;
    denominator = denominator * (m + 1) * m;
    numerator   = numerator   * x * x;
    var a       = numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (Math.abs(a) <= 0.00000000001) 
        return y;
    else
        return y + mySinh(x, ++n, numerator, denominator, a);
}
