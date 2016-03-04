// ‰€:a, Œö·:a ‚Å, ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
def sn(a:Int, lim:Int) = {
    val n = lim / a  // €”:n  =  ãŒÀ:lim / Œö·:a
    val l = n * a    // ––€:l  =  €”:n   * Œö·:a
    (a + l) * n / 2  // ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
}
// 3 ‚Ì”{”‚Ì‡Œv
sn(3,999)
