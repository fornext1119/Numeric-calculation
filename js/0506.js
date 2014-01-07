for (var i = 1; i <= 20; i++)
{
    var x  = i / 5.0;
    // 標準の対数関数
    var d1 = Math.log(x);
    // 自作の対数関数
    var x2 = (x - 1) / (x + 1);  
    var d2 = 2 * myLog(x2, x2, 1.0, x2);
    // 標準関数との差異
    WScript.StdOut.Write(("     "         + x.toFixed(2)         ).slice(-5)  + " : ");
    WScript.StdOut.Write(("             " + d1.toFixed(10)       ).slice(-13) + " - ");
    WScript.StdOut.Write(("             " + d2.toFixed(10)       ).slice(-13) + " = ");
    WScript.StdOut.Write(("             " + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
}

// 自作の対数関数
function myLog(x2, numerator, denominator, y) 
{
    denominator = denominator + 2;
    numerator   = numerator   * x2 * x2;
    var a       = numerator / denominator;
    // 十分な精度になったら処理を抜ける
    if (Math.abs(a) <= 0.00000000001)
        return y;
    else
        return y + myLog(x2, numerator, denominator, a);
}
