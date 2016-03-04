for (var i = 1; i <= 20; i++)
{
    var x  = i / 5.0;
    // �W���̑ΐ��֐�
    var d1 = Math.log(x);
    // ����̑ΐ��֐�
    var d2 = myLog(x - 1, 27, 0.0); // 27:�K�v�Ȑ��x��������\���傫�Ȋ
    // �W���֐��Ƃ̍���
    WScript.StdOut.Write(("     "         + x.toFixed(2)         ).slice(-5)  + " : ");
    WScript.StdOut.Write(("             " + d1.toFixed(10)       ).slice(-13) + " - ");
    WScript.StdOut.Write(("             " + d2.toFixed(10)       ).slice(-13) + " = ");
    WScript.StdOut.Write(("             " + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
}

// ����̑ΐ��֐�
function myLog(x, n, t)
{
    var n2 = n;
    var x2 = x;
    if (n > 3)
    {
        if (n % 2 == 0)
            n2 = 2;
        x2 = x * parseInt(n / 2);
    }
    t = x2 / (n2 + t);

    if (n <= 2)
        return x / (1 + t);
    else
        return myLog(x, --n, t);
}
