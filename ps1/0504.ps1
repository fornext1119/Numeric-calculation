# 自作の指数関数
function myExp($x, $n, $numerator, $denominator, $y)
{
    $denominator = $denominator * $n
    $numerator   = $numerator   * $x
    $a           = $numerator / $denominator
    # 十分な精度になったら処理を抜ける
    if ([Math]::Abs($a) -le 0.00000000001)
    {
        $y
    }
    else
    {
        $y + (myExp $x ($n + 1) $numerator $denominator $a)
    }
}

foreach ($i in 0..20)
{
    $x = ($i - 10) / 4.0
    # 標準の指数関数
    $d1 = [Math]::Exp($x)
    # 自作の指数関数
    $d2 = myExp $x 1 1.0 1.0 1.0
    # 標準関数との差異
    Write-Host ([string]::format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", $x, $d1, $d2, $d1 - $d2))
}
