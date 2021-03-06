for (var x = -10; x <= 10; x++)
{
    // 自作の双曲線正弦関数
    var d1 = mySinh(x, 1, x, 1.0, x);
    // 標準の双曲線正弦関数はない
    var d2 = (Math.exp(x) - Math.exp(-x)) / 2;
    // 標準関数との差異
    WScript.StdOut.Write(("   "               + x                    ).slice( -3) + " : ");
    WScript.StdOut.Write(("                 " + d1.toFixed(10)       ).slice(-17) + " - ");
    WScript.StdOut.Write(("                 " + d2.toFixed(10)       ).slice(-17) + " = ");
    WScript.StdOut.Write(("             "     + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
}

// 自作の双曲線正弦関数
function mySinh(x, n, numerator, denominator, y) 
{
    var m       = 2 * n;
    denominator = denominator * (m + 1) * m;
    numerator   = numerator   * x * x;
    var a       = numerator / denominator;
    // 十分な精度になったら処理を抜ける
    if (Math.abs(a) <= 0.00000000001) 
        return y;
    else
        return y + mySinh(x, ++n, numerator, denominator, a);
}
