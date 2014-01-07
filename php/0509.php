<?php
# 自作の双曲線余弦関数
function myCosh($x, $n, $numerator, $denominator, $y)
{
    $m           = 2 * $n;
    $denominator = $denominator * $m * ($m - 1);
    $numerator   = $numerator * $x * $x;
    $a           = $numerator / $denominator;

    # 十分な精度になったら処理を抜ける
    if (abs($a) <= 0.00000000001)
        return $y;
    else
        return $y + myCosh($x, ++$n, $numerator, $denominator, $a);
}

foreach (range(0, 20) as $i)
{
    $x  = $i - 10;
    # 自作の双曲線余弦関数
    $d1 = myCosh($x, 1, 1.0, 1.0, 1.0);
    # 標準の双曲線余弦関数
    $d2 = cosh($x);
    # 標準関数との差異
    printf("%3d : %17.10f - %17.10f = %13.10f\n", $x, $d1, $d2, $d1 - $d2);
}
?>
