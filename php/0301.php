<?php
# ����:a, ����:a �� ���:lim �̐���̑��a��Ԃ��֐�
function sn($a, $lim)
{
    $n = (int)($lim / $a);     # ����:n  =  ���:lim / ����:a
    $l = $n * $a;              # ����:l  =  ����:n   * ����:a
    return ($a + $l) * $n / 2; # ���a:sn = (����:a   + ����:l) * ����:n / 2
}

# 3 �̔{���̍��v
$sum = sn(3, 999);
echo $sum, "\n";
?>
