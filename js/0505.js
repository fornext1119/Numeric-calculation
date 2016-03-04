for (var i = -10; i <= 10; i++)
{
    var x  = i / 4.0;
    // 標準の指数関数
    var d1 = Math.exp(x);
    // 自作の指数関数
    var x2 = x * x;
    var d2 = myExp(x, x2, 30, 0.0); // 30:必要な精度が得られるよう, 6から始めて4ずつ増加させる
    // 標準関数との差異
    WScript.StdOut.Write(("     "         + x.toFixed(2)         ).slice(-5)  + " : ");
    WScript.StdOut.Write(("             " + d1.toFixed(10)       ).slice(-13) + " - ");
    WScript.StdOut.Write(("             " + d2.toFixed(10)       ).slice(-13) + " = ");
    WScript.StdOut.Write(("             " + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
}

// 自作の指数関数
function myExp(x, x2, n, t)
{
    t = x2 / (n + t);
    n -= 4;  

    if (n < 6)
        return 1 + ((2 * x) / (2 - x + t));
    else
        return myExp(x, x2, n, t);
}
