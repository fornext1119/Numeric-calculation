for (var x = -10; x <= 10; x++)
{
    // Ž©ì‚Ì‘o‹Èü³Œ·ŠÖ”
    var d1 = mySinh(x, 1, x, 1.0, x);
    // •W€‚Ì‘o‹Èü³Œ·ŠÖ”‚Í‚È‚¢
    var d2 = (Math.exp(x) - Math.exp(-x)) / 2;
    // •W€ŠÖ”‚Æ‚Ì·ˆÙ
    WScript.StdOut.Write(("   "               + x                    ).slice( -3) + " : ");
    WScript.StdOut.Write(("                 " + d1.toFixed(10)       ).slice(-17) + " - ");
    WScript.StdOut.Write(("                 " + d2.toFixed(10)       ).slice(-17) + " = ");
    WScript.StdOut.Write(("             "     + (d1 - d2).toFixed(10)).slice(-13) + "\n" );
}

// Ž©ì‚Ì‘o‹Èü³Œ·ŠÖ”
function mySinh(x, n, numerator, denominator, y) 
{
    var m       = 2 * n;
    denominator = denominator * (m + 1) * m;
    numerator   = numerator   * x * x;
    var a       = numerator / denominator;
    // \•ª‚È¸“x‚É‚È‚Á‚½‚çˆ—‚ð”²‚¯‚é
    if (Math.abs(a) <= 0.00000000001) 
        return y;
    else
        return y + mySinh(x, ++n, numerator, denominator, a);
}
