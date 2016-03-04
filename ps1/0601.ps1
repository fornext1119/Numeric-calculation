function f($x)
{
    4 / (1 + $x * $x)
}

$a = 0
$b = 1

# ë‰å`ë•Ç≈êœï™
$n = 2;
foreach ($j in 1..10)
{
    $h = ($b - $a) / $n
    $s = 0
    $x = $a
    foreach ($i in 1..($n - 1))
    {
        $x += $h
        $s += (f $x)
    }
    $s = $h * (((f $a) + (f $b)) / 2 + $s)
    $n *= 2

    # åãâ Ç ÉŒ Ç∆î‰är
    Write-Host ([string]::format("{0,2:D} : {1,13:F10}, {2,13:F10}", $j, $s, $s - [Math]::PI))
}
