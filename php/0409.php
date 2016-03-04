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

# 重複組合せ (異なる 10 個のものから重複を許して 5 個とる組合せの総数)
$n = 10;
$r = 5;
echo Comb($n + $r - 1, $r), "\n";
?>
