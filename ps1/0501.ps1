# 自作の正弦関数
function mySin($x, $n, $nega, $numerator, $denominator, $y)
{
    $m           = 2 * $n
    $denominator = $denominator * ($m + 1) * $m
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
        $y + (mySin $x  ($n + 1) (-not $nega) $numerator $denominator $a)
    }
}

foreach ($i in 0..24)
{
    $degree = $i * 15
    if ($degree % 30 -eq 0 -or $degree % 45 -eq 0)
    {
        $radian = $degree * [Math]::PI / 180.0
        # 自作の正弦関数
        $d1     = mySin $radian 1 $false $radian 1.0 $radian
        # 標準の正弦関数
        $d2     = [Math]::Sin($radian)
        # 標準関数との差異
        Write-Host ([string]::format("{0,3:D} : {1,13:F10} - {2,13:F10} = {3,13:F10}", $degree, $d1, $d2, $d1 - $d2))
    }
}
