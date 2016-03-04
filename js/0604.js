var a = 0
var b = 1

var t = []

// ‘äŒ`‘¥‚ÅÏ•ª
var n = 2;
for (var i = 1; i <= 6; i++)
{
    var h = (b - a) / n 
    var s = 0
    var x = a
    for (var j = 1; j <= n - 1; j++)
    {
        x += h
        s += f(x)
    }
    // Œ‹‰Ê‚ğ•Û‘¶
    t[i]    = []
    t[i][1] = h * ((f(a) + f(b)) / 2 + s)
    n *= 2
}

// Richardson‚Ì•âŠO–@
n = 4
for (var j = 2; j <= 6; j++)
{
    for (var i = j; i <= 6; i++)
    {
        t[i][j] = t[i][j - 1] + (t[i][j - 1] - t[i - 1][j - 1]) / (n - 1)
        if (i == j)
        {
            // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
            WScript.StdOut.Write(("  "            + j                              ).slice( -2) + " : ");
            WScript.StdOut.Write(("             " + t[i][j].toFixed(10)            ).slice(-13) + ", ");
            WScript.StdOut.Write(("             " + (t[i][j] - Math.PI).toFixed(10)).slice(-13) + "\n" );
        }
    }
    n *= 4
}

function f(x)
{
    return 4 / (1 + x * x)
}
