# 自作の対数関数
function myLog($x, $n, $t)
{
    $n2 = $n
    $x2 = $x
    if ($n -gt 3)
    {
        if ($n % 2 -eq 0)
        {
            $n2 = 2
        }
        $x2 = $x * [Math]::Floor($n / 2)
    }
    $t = $x2 / ($n2 + $t)

    if ($n -le 2)
    {
        $x / (1 + $t)
    }
    else
    {
        myLog $x ($n - 1) $t
    }
}

foreach ($i in 1..20)
{
    $x = $i / 5.0
    # 標準の対数関数
    $d1 = [Math]::Log($x)
    # 自作の対数関数
    $d2 = myLog ($x - 1) 27 0.0 # 27:必要な精度が得られる十分大きな奇数
    # 標準関数との差異
    Write-Host ([string]::format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", $x, $d1, $d2, $d1 - $d2))
}
