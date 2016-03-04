# 自作の対数関数
sub myLog
{
    my ($x2, $numerator, $denominator, $y) = @_;

    $denominator = $denominator + 2;
    $numerator   = $numerator   * $x2 * $x2;
    $a           = $numerator / $denominator;
    # 十分な精度になったら処理を抜ける
    if (abs($a) <= 0.00000000001)
    {
        $y;
    }
    else
    {
        $y + myLog($x2, $numerator, $denominator, $a);
    }
}

for $i (1..20)
{
    $x  = $i / 5.0;
    # 標準の対数関数
    $d1 = log($x);
    # 自作の対数関数
    $x2 = ($x - 1) / ($x + 1);  
    $d2 = 2 * myLog($x2, $x2, 1.0, $x2);
    # 標準関数との差異
    printf("%5.2f : %13.10f - %13.10f = %13.10f\n", $x, $d1, $d2, $d1 - $d2);
}
