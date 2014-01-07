# 自作の双曲線余弦関数
function myCosh($x, $n, $numerator, $denominator, $y)
{
    $m           = 2 * $n
    $denominator = $denominator * $m * ($m - 1)
    $numerator   = $numerator   * $x * $x
    $a           = $numerator / $denominator
    # 十分な精度になったら処理を抜ける
    if ([Math]::Abs($a) -le 0.00000000001) 
    {
        $y
    }
    else
    {
        $y + (myCosh $x ($n + 1) $numerator $denominator $a)
    }
}

foreach ($i in 0..20)
{
    $x = $i - 10
    # 自作の双曲線余弦関数
    $d1 = myCosh $x 1 1.0 1.0 1.0
    # 標準の双曲線余弦関数
    $d2 = [Math]::Cosh($x)
    # 標準関数との差異
    Write-Host ([string]::format("{0,3:D} : {1,17:F10} - {2,17:F10} = {3,13:F10}", $x, $d1, $d2, $d1 - $d2))
}
