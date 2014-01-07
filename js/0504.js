for (var i = -10; i <= 10; i++)
{
    var x  = i / 4.0;
    // �W���̎w���֐�
    var d1 = Math.exp(x);
    // ����̎w���֐�
    var d2 = myExp(x, 1, 1.0, 1.0, 1.0);
    // �W���֐��Ƃ̍���
    WScript.StdOut.Write(("     "         + x.toFixed(2)         ).slice(-5)  + " : ");
    WScript.StdOut.Write(("             " + d1.toFixed(10)       ).slice(-13) + " - ");
    WScript.StdOut.Write(("             " + d2.toFixed(10)       ).slice(-13) + " = ");
    WScript.StdOut.Write(("             " + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
}

// ����̎w���֐�
function myExp(x, n, numerator, denominator, y)
{
    denominator = denominator * n;
    numerator   = numerator   * x;
    var a       = numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (Math.abs(a) <= 0.00000000001)
        return y;
    else
        return y + myExp(x, ++n, numerator, denominator, a);
}
