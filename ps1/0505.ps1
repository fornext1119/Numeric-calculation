# 自作の指数関数
function myExp($x, $x2, $n, $t)
{
    $t = $x2 / ($n + $t)
    $n -= 4  

    if ($n -lt 6)
    {
        1 + ((2 * $x) / (2 - $x + $t))
    }
    else
    {
        myExp $x $x2 $n $t
    }
}

foreach ($i in 0..20)
{
    $x = ($i - 10) / 4.0
    # 標準の指数関数
    $d1 = [Math]::Exp($x)
    # 自作の指数関数
    $x2 = $x * $x
    $d2 = myExp $x $x2 30 0.0 # 30:必要な精度が得られるよう, 6から始めて4ずつ増加させる
    # 標準関数との差異
    Write-Host ([string]::format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", $x, $d1, $d2, $d1 - $d2))
}
