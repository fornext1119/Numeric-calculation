for (var degree = -90; degree <= 90; degree += 15)
{
    if ((degree + 90) % 180 != 0)
    {
        var radian = degree * Math.PI / 180.0;
        var x2     = radian * radian;
        // 自作の正接関数
        var d1     = myTan(radian, x2, 15, 0.0); // 15:必要な精度が得られる十分大きな奇数
        // 標準の正接関数
        var d2     = Math.tan(radian);
        // 標準関数との差異
        WScript.StdOut.Write(("   "           + degree               ).slice( -3) + " : ");
        WScript.StdOut.Write(("             " + d1.toFixed(10)       ).slice(-13) + " - ");
        WScript.StdOut.Write(("             " + d2.toFixed(10)       ).slice(-13) + " = ");
        WScript.StdOut.Write(("             " + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
    }
}

// 自作の正接関数
function myTan(x, x2, n, t)
{
    t = x2 / (n - t);
    n -= 2;  
    if (n <= 1) 
        return x / (1 - t);
    else
        return myTan(x, x2, n, t);
}
