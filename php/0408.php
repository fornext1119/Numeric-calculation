<?php
# ‘g‡‚¹
function Comb($n, $r)
{
    if ($r == 0 || $r == $n)
        return 1;
    elseif ($r == 1)
        return $n;
    else
        return Comb($n - 1, $r - 1) + Comb($n - 1, $r);
}

# ‘g‡‚¹ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂŽæ‚Á‚Ä‚Å‚«‚é‘g‡‚¹‚Ì‘”)
$n = 10;
$r = 5;
echo Comb($n, $r), "\n";
?>
