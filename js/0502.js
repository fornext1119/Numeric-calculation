for (var degree = 0; degree <= 360; degree += 15)
{
    if (degree % 30 == 0 || degree % 45 == 0)
    {
        var radian = degree * Math.PI / 180.0;
        // 自作の余弦関数
        var d1     = myCos(radian, 1, false, 1.0, 1.0, 1.0);
        // 標準の余弦関数
        var d2     = Math.cos(radian);
        // 標準関数との差異
        WScript.StdOut.Write(("   "           + degree               ).slice( -3) + " : ");
        WScript.StdOut.Write(("             " + d1.toFixed(10)       ).slice(-13) + " - ");
        WScript.StdOut.Write(("             " + d2.toFixed(10)       ).slice(-13) + " = ");
        WScript.StdOut.Write(("             " + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
    }
}

// 自作の余弦関数
function myCos(x, n, nega, numerator, denominator, y)
{
    var m       = 2 * n;
    denominator = denominator * m * (m - 1);
    numerator   = numerator * x * x;
    var a       = numerator / denominator;
    // 十分な精度になったら処理を抜ける
    if (a <= 0.00000000001)
        return y;
    else
        return y + myCos(x, ++n, !nega, numerator, denominator, nega ? a : -a);
}
