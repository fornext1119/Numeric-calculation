<?php
# 自作の余弦関数
function myCos($x, $n, $nega, $numerator, $denominator, $y)
{
    $m           = 2 * $n;
    $denominator = $denominator * $m * ($m - 1);
    $numerator   = $numerator * $x * $x;
    $a           = $numerator / $denominator;
    # 十分な精度になったら処理を抜ける
    if ($a <= 0.00000000001)
        return $y;
    else
        return $y + myCos($x, ++$n, !$nega, $numerator, $denominator, $nega ? $a : -$a);
}

foreach (range(0, 24) as $i)
{
    $degree = $i * 15;
    if ($degree % 30 == 0 || $degree % 45 == 0)
    {
        $radian = deg2rad($degree);
        # 自作の余弦関数
        $d1     = myCos($radian, 1, false, 1.0, 1.0, 1.0);
        # 標準の余弦関数
        $d2     = cos($radian);
        # 標準関数との差異
        printf("%3d : %13.10f - %13.10f = %13.10f\n", $degree, $d1, $d2, $d1 - $d2);
    }
}
?>
