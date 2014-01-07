// ‰º~ŠKæ™p
function FallingFact(x, n) {
    if (n <= 1)
        return x
    else
        return x * FallingFact(x - 1, n - 1)
}

// 10 ‚©‚ç 6 ‚Ü‚Å‚Ì ‘æ
WScript.Echo(FallingFact(10, 5))
WScript.Echo(10 * 9 * 8 * 7 * 6)
