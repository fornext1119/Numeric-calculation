<?php
$a = 5;  # ���� 5
$d = 3;  # ���� 3
$n = 10; # ���� 10
$p = 1;  # ��

foreach (range(1, $n) as $i)
{
    $m = $a + ($d * ($i - 1));
    $p *= $m;
}
echo $p;
?>
