<?php
# �K��
function Fact($n)
{
    if ($n <= 1)
        return 1;
    else
        return $n * Fact($n - 1);
}

# ���~�K��p
function FallingFact($x, $n)
{
    if ($n <= 1)
        return $x;
    else
        return $x * FallingFact($x - 1, $n - 1);
}

# ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
$n = 10;
$r = 5;
echo Fact($n) / Fact($n - $r), "\n";
echo FallingFact($n, $r), "\n";
?>
