function f($x)
{
    4 / (1 + $x * $x)
}

$a = 0
$b = 1

# ’†“_‘¥‚ÅÏ•ª
$n = 2;
foreach ($j in 1..10)
{
    $h = ($b - $a) / $n
    $s = 0
    $x = $a + ($h / 2)
    foreach ($i in 1..$n)
    {
        $s += (f $x)
        $x += $h
    }
    $s *= $h
    $n *= 2

    # Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
    Write-Host ([string]::format("{0,2:D} : {1,13:F10}, {2,13:F10}", $j, $s, $s - [Math]::PI))
}
