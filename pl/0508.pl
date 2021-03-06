use Math::Trig;

# 自作の双曲線正弦関数
sub mySinh
{
    my ($x, $n, $numerator, $denominator, $y) = @_;

    $m           = 2 * $n;
    $denominator = $denominator * ($m + 1) * $m;
    $numerator   = $numerator * $x * $x;
    $a           = $numerator / $denominator;

    # 十分な精度になったら処理を抜ける
    if (abs($a) <= 0.00000000001)
    {
        $y;
    }
    else
    {
        $y + mySinh($x, ++$n, $numerator, $denominator, $a);
    }
}

for $i (0..20)
{
    $x  = $i - 10;
    # 自作の双曲線正弦関数
    $d1 = mySinh($x, 1, $x, 1.0, $x);
    # 標準の双曲線正弦関数
    $d2 = sinh($x);
    # 標準関数との差異
    printf("%3d : %17.10f - %17.10f = %13.10f\n", $x, $d1, $d2, $d1 - $d2);
}
