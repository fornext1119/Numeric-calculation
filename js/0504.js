for (var i = -10; i <= 10; i++)
{
    var x  = i / 4.0;
    // 標準の指数関数
    var d1 = Math.exp(x);
    // 自作の指数関数
    var d2 = myExp(x, 1, 1.0, 1.0, 1.0);
    // 標準関数との差異
    WScript.StdOut.Write(("     "         + x.toFixed(2)         ).slice(-5)  + " : ");
    WScript.StdOut.Write(("             " + d1.toFixed(10)       ).slice(-13) + " - ");
    WScript.StdOut.Write(("             " + d2.toFixed(10)       ).slice(-13) + " = ");
    WScript.StdOut.Write(("             " + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
}

// 自作の指数関数
function myExp(x, n, numerator, denominator, y)
{
    denominator = denominator * n;
    numerator   = numerator   * x;
    var a       = numerator / denominator;
    // 十分な精度になったら処理を抜ける
    if (Math.abs(a) <= 0.00000000001)
        return y;
    else
        return y + myExp(x, ++n, numerator, denominator, a);
}
