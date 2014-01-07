// ‰€:a, Œö·:a ‚Å, ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
let sn a lim =
    let n = lim / a in  // €”:n  =  ãŒÀ:lim / Œö·:a
    let l = a * n in    // ––€:l  =  €”:n   * Œö·:a
    (a + l) * n / 2     // ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
// 3 ‚Ì”{”‚Ì‡Œv
(sn 3 999)
