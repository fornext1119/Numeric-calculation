// ‰€:a, Œö·:a ‚Å ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
function sn(a, lim) {
    var n = parseInt(lim / a) // €”:n  =  ãŒÀ:lim / Œö·:a
    var l = n * a             // ––€:l  =  €”:n   * Œö·:a
    return (a + l) * n / 2    // ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
}

// 3 ‚Ì”{”‚Ì‡Œv
WScript.Echo(sn(3, 999))
