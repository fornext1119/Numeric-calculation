<?php
# ‰€:a, Œö·:a ‚Å ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ð•Ô‚·ŠÖ”
function sn($a, $lim)
{
    $n = (int)($lim / $a);     # €”:n  =  ãŒÀ:lim / Œö·:a
    $l = $n * $a;              # ––€:l  =  €”:n   * Œö·:a
    return ($a + $l) * $n / 2; # ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
}

# 3 ‚Ì”{”‚Ì‡Œv
$sum = sn(3, 999);
echo $sum, "\n";
?>
