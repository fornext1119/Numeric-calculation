# 自作の対数関数
sub myLog
{
    my ($x, $n, $t) = @_;

    $n2 = $n;
    $x2 = $x;
    if ($n > 3)
    {
        if ($n % 2 == 0)
        {
            $n2 = 2;
        }
        $x2 = $x * int($n / 2);
    }
    $t = $x2 / ($n2 + $t);

    if ($n <= 2)
    {
        $x / (1 + $t);
    }
    else
    {
        myLog($x, --$n, $t);
    }
}

for $i (1..20)
{
    $x  = $i / 5.0;
    # 標準の対数関数
    $d1 = log($x);
    # 自作の対数関数
    $d2 = myLog($x - 1, 27, 0.0); # 27:必要な精度が得られる十分大きな奇数
    # 標準関数との差異
    printf("%5.2f : %13.10f - %13.10f = %13.10f\n", $x, $d1, $d2, $d1 - $d2);
}
