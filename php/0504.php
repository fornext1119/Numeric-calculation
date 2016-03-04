<?php
# 自作の指数関数
function myExp($x, $n, $numerator, $denominator, $y)
{
    $denominator = $denominator * $n;
    $numerator   = $numerator   * $x;
    $a           = $numerator / $denominator;
    # 十分な精度になったら処理を抜ける
    if (abs($a) <= 0.00000000001)
        return $y;
    else
        return $y + myExp($x, ++$n, $numerator, $denominator, $a);
}

foreach (range(0, 20) as $i)
{
    $x  = ($i - 10) / 4.0;
    # 標準の指数関数
    $d1 = exp($x);
    # 自作の指数関数
    $d2 = myExp($x, 1, 1.0, 1.0, 1.0);
    # 標準関数との差異
    printf("%5.2f : %13.10f - %13.10f = %13.10f\n", $x, $d1, $d2, $d1 - $d2);
}
?>
