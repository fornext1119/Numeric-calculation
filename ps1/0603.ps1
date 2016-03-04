function f($x)
{
    4 / (1 + $x * $x)
}

$a = 0
$b = 1

# Simpsonë•Ç≈êœï™
$n = 2;
foreach ($j in 1..5)
{
    $h  = ($b - $a) / $n
    $s2 = 0
    $s4 = 0
    $x  = $a + $h
    foreach ($i in 1..($n / 2))
    {
        $s4 += (f $x)
        $x  += $h
        $s2 += (f $x)
        $x  += $h
    }
    $s2 = ($s2 - (f $b)) * 2 + (f $a) + (f $b)
    $s4 *= 4
    $s  = ($s2 + $s4) * $h / 3
    $n  *= 2

    # åãâ Ç ÉŒ Ç∆î‰är
    Write-Host ([string]::format("{0,2:D} : {1,13:F10}, {2,13:F10}", $j, $s, $s - [Math]::PI))
}
