<?php
$a = 5;  # ‰€ 5
$d = 3;  # Œö· 3
$n = 10; # €” 10
$p = 1;  # Ï

foreach (range(1, $n) as $i)
{
    $m = $a + ($d * ($i - 1));
    $p *= $m;
}
echo $p;
?>
