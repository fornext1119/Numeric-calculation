var a = 0
var b = 1

// Simpson‘¥‚ÅÏ•ª
var n = 2
for (var j = 1; j <= 5; j++)
{
    var h  = (b - a) / n 
    var s2 = 0
    var s4 = 0
    var x  = a + h
    for (var i = 1; i <= n / 2; i++)
    {
        s4 += f(x)
        x  += h
        s2 += f(x)
        x  += h
    }
    s2 = (s2 - f(b)) * 2 + f(a) + f(b)
    s4 *= 4
    var s = (s2 + s4) * h / 3
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
