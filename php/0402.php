<?php
# ���� 5, ���� 3, ���� 10 �̐���̐ς�\������
echo product(5, 3, 10);

function product($m, $d, $n)
{
    if ($n == 0)
        return 1;
    else
        return $m * product($m + $d, $d, $n - 1);
}
?>
