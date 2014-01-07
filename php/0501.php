<?php
# ����̐����֐�
function mySin($x, $n, $nega, $numerator, $denominator, $y)
{
    $m           = 2 * $n;
    $denominator = $denominator * ($m + 1) * $m;
    $numerator   = $numerator * $x * $x;
    $a           = $numerator / $denominator;
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if ($a <= 0.00000000001)
        return $y;
    else
        return $y + mySin($x, ++$n, !$nega, $numerator, $denominator, $nega ? $a : -$a);
}

foreach (range(0, 24) as $i)
{
    $degree = $i * 15;
    if ($degree % 30 == 0 || $degree % 45 == 0)
    {
        $radian = deg2rad($degree);
        # ����̐����֐�
        $d1     = mySin($radian, 1, false, $radian, 1.0, $radian);
        # �W���̐����֐�
        $d2     = sin($radian);
        # �W���֐��Ƃ̍���
        printf("%3d : %13.10f - %13.10f = %13.10f\n", $degree, $d1, $d2, $d1 - $d2);
    }
}
?>
