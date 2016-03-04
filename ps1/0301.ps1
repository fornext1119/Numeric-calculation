# ‰€:a, Œö·:a ‚Å, ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
function sn($a, $lim)
{
    $n = [math]::floor($lim / $a) # €”:n  =  ãŒÀ:lim / Œö·:a
    $l = $n * $a                  # ––€:l  =  €”:n   * Œö·:a
    ($a + $l) * $n / 2            # ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
}

# 3 ‚Ì”{”‚Ì‡Œv
Write-Host (sn 3 999)
