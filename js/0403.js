// ŠKæ‚ğ‹‚ß‚éŠÖ”
function Fact(n) {
    if (n <= 1)
        return 1
    else
        return n * Fact(n - 1)
}

// 10‚ÌŠKæ
WScript.Echo(Fact(10))
WScript.Echo(10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1)
