for (var degree = -90; degree <= 90; degree += 15)
{
    if ((degree + 90) % 180 != 0)
    {
        var radian = degree * Math.PI / 180.0;
        var x2     = radian * radian;
        // ����̐��ڊ֐�
        var d1     = myTan(radian, x2, 15, 0.0); // 15:�K�v�Ȑ��x��������\���傫�Ȋ
        // �W���̐��ڊ֐�
        var d2     = Math.tan(radian);
        // �W���֐��Ƃ̍���
        WScript.StdOut.Write(("   "           + degree               ).slice( -3) + " : ");
        WScript.StdOut.Write(("             " + d1.toFixed(10)       ).slice(-13) + " - ");
        WScript.StdOut.Write(("             " + d2.toFixed(10)       ).slice(-13) + " = ");
        WScript.StdOut.Write(("             " + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
    }
}

// ����̐��ڊ֐�
function myTan(x, x2, n, t)
{
    t = x2 / (n - t);
    n -= 2;  
    if (n <= 1) 
        return x / (1 - t);
    else
        return myTan(x, x2, n, t);
}
