var a = 0
var b = 1

// ‘äŒ`‘¥‚ÅÏ•ª
var n = 2;
for (var j = 1; j <= 10; j++)
{
    var h = (b - a) / n 
    var s = 0
    var x = a
    for (var i = 1; i <= n - 1; i++)
    {
        x += h
        s += f(x)
    }
    s = h * ((f(a) + f(b)) / 2 + s)
    n *= 2

    // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
    WScript.StdOut.Write(("  "            + j                        ).slice( -2) + " : ");
    WScript.StdOut.Write(("             " + s.toFixed(10)            ).slice(-13) + ", ");
    WScript.StdOut.Write(("             " + (s - Math.PI).toFixed(10)).slice(-13) + "\n" );
}

function f(x)
{
    return 4 / (1 + x * x)
}
