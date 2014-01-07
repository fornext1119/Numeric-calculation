function f($x)
{
    4 / (1 + $x * $x)
}

$a = 0
$b = 1

# ‘äŒ`‘¥‚ÅÏ•ª
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

    # Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
    Write-Host ([string]::format("{0,2:D} : {1,13:F10}, {2,13:F10}", $j, $s, $s - [Math]::PI))
}
