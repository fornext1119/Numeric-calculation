for (var i = -10; i <= 10; i++)
{
    var x  = i / 4.0;
    // �W���̎w���֐�
    var d1 = Math.exp(x);
    // ����̎w���֐�
    var x2 = x * x;
    var d2 = myExp(x, x2, 30, 0.0); // 30:�K�v�Ȑ��x��������悤, 6����n�߂�4������������
    // �W���֐��Ƃ̍���
    WScript.StdOut.Write(("     "         + x.toFixed(2)         ).slice(-5)  + " : ");
    WScript.StdOut.Write(("             " + d1.toFixed(10)       ).slice(-13) + " - ");
    WScript.StdOut.Write(("             " + d2.toFixed(10)       ).slice(-13) + " = ");
    WScript.StdOut.Write(("             " + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
}

// ����̎w���֐�
function myExp(x, x2, n, t)
{
    t = x2 / (n + t);
    n -= 4;  

    if (n < 6)
        return 1 + ((2 * x) / (2 - x + t));
    else
        return myExp(x, x2, n, t);
}
