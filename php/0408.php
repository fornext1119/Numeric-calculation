<?php
# 組合せ
function Comb($n, $r)
{
    if ($r == 0 || $r == $n)
        return 1;
    elseif ($r == 1)
        return $n;
    else
        return Comb($n - 1, $r - 1) + Comb($n - 1, $r);
}

# 組合せ (異なる 10 個のものから 5 個取ってできる組合せの総数)
$n = 10;
$r = 5;
echo Comb($n, $r), "\n";
?>
