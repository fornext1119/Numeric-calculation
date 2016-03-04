use Math::Trig qw'deg2rad tan';

# 自作の正弦関数
sub mySin
{
    my ($x, $n, $nega, $numerator, $denominator, $y) = @_;

    $m           = 2 * $n;
    $denominator = $denominator * ($m + 1) * $m;
    $numerator   = $numerator * $x * $x;
    $a           = $numerator / $denominator;
    # 十分な精度になったら処理を抜ける
    if ($a <= 0.00000000001)
    {
        $y;
    }
    else
    {
        $y + mySin($x, ++$n, !$nega, $numerator, $denominator, $nega ? $a : -$a);
    }
}

for $i (0..24)
{
    $degree = $i * 15;
    if ($degree % 30 == 0 || $degree % 45 == 0)
    {
        $radian = deg2rad($degree);
        # 自作の正弦関数
        $d1     = mySin($radian, 1, 0, $radian, 1.0, $radian);
        # 標準の正弦関数
        $d2     = sin($radian);
        # 標準関数との差異
        printf("%3d : %13.10f - %13.10f = %13.10f\n", $degree, $d1, $d2, $d1 - $d2);
    }
}
