# 自作の余弦関数
function myCos($x, $n, $nega, $numerator, $denominator, $y)
{
    $m           = 2 * $n
    $denominator = $denominator * $m * ($m - 1)
    $numerator   = $numerator * $x * $x
    $a           = $numerator / $denominator
    # 十分な精度になったら処理を抜ける
    if ($a -le 0.00000000001)
    {
        $y
    }
    else
    {
        if (-not $nega) { $a = -$a}
        $y + (myCos $x  ($n + 1) (-not $nega) $numerator $denominator $a)
    }
}

foreach ($i in 0..24)
{
    $degree = $i * 15
    if ($degree % 30 -eq 0 -or $degree % 45 -eq 0)
    {
        $radian = $degree * [Math]::PI / 180.0
        # 自作の余弦関数
        $d1     = myCos $radian 1 $false 1.0 1.0 1.0
        # 標準の余弦関数
        $d2     = [Math]::Cos($radian)
        # 標準関数との差異
        Write-Host ([string]::format("{0,3:D} : {1,13:F10} - {2,13:F10} = {3,13:F10}", $degree, $d1, $d2, $d1 - $d2))
    }
}
