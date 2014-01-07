# ‰€:a, Œö·:a ‚Å ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
def sn(a, lim)
    n = lim / a      # €”:n  =  ãŒÀ:lim / Œö·:a
    l = n * a        # ––€:l  =  €”:n   * Œö·:a
    (a + l) * n / 2  # ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
end

# 3 ‚Ì”{”‚Ì‡Œv
sum = sn(3, 999)
puts sum
