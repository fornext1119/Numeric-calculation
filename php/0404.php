<?php
# ���~�K��p
function FallingFact($x, $n)
{
    if ($n <= 1)
        return $x;
    else
        return $x * FallingFact($x - 1, $n - 1);
}

# 10 ���� 6 �܂ł� ����
echo FallingFact(10, 5), "\n";
echo 10 * 9 * 8 * 7 * 6, "\n";
?>
