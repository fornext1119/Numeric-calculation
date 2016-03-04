for (var x = -10; x <= 10; x++)
{
    // 自作の双曲線余弦関数
    var d1 = myCosh(x, 1, 1.0, 1.0, 1.0);
    // 標準の双曲線余弦関数はない
    var d2 = (Math.exp(x) + Math.exp(-x)) / 2;
    // 標準関数との差異
    WScript.StdOut.Write(("   "               + x                    ).slice( -3) + " : ");
    WScript.StdOut.Write(("                 " + d1.toFixed(10)       ).slice(-17) + " - ");
    WScript.StdOut.Write(("                 " + d2.toFixed(10)       ).slice(-17) + " = ");
    WScript.StdOut.Write(("             "     + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
}

// 自作の双曲線余弦関数
function myCosh(x, n, numerator, denominator, y) 
{
    var m       = 2 * n;
    denominator = denominator * m * (m - 1);
    numerator   = numerator   * x * x;
    var a       = numerator / denominator;
    // 十分な精度になったら処理を抜ける
    if (Math.abs(a) <= 0.00000000001) 
        return y;
    else
        return y + myCosh(x, ++n, numerator, denominator, a);
}
