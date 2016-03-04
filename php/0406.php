<?php
# ŠKæ
function Fact($n)
{
    if ($n <= 1)
        return 1;
    else
        return $n * Fact($n - 1);
}

# ‰º~ŠKæ™p
function FallingFact($x, $n)
{
    if ($n <= 1)
        return $x;
    else
        return $x * FallingFact($x - 1, $n - 1);
}

# ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂŽæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
$n = 10;
$r = 5;
echo Fact($n) / Fact($n - $r), "\n";
echo FallingFact($n, $r), "\n";
?>
