function f($x)
{
    4 / (1 + $x * $x)
}

$a = 0
$b = 1

$t = New-Object "double[,]" 7,7

# ë‰å`ë•Ç≈êœï™
$n = 2;
foreach ($i in 1..6)
{
    $h = ($b - $a) / $n
    $s = 0
    $x = $a
    foreach ($j in 1..($n - 1))
    {
        $x += $h
        $s += (f $x)
    }
    # åãâ Çï€ë∂
    $t[$i,1] = $h * (((f $a) + (f $b)) / 2 + $s)
    $n *= 2
}

# RichardsonÇÃï‚äOñ@
$n = 4
foreach ($j in 2..6)
{
    foreach ($i in $j..6)
    {
        $t1 = $t[ $i     ,($j - 1)]
        $t2 = $t[($i - 1),($j - 1)]
        $t[$i,$j] = $t1 + ($t1 - $t2) / ($n - 1)
        if ($i -eq $j)
        {
            # åãâ Ç ÉŒ Ç∆î‰är
            $s = $t[$i,$j]
            Write-Host ([string]::format("{0,2:D} : {1,13:F10}, {2,13:F10}", $j, $s, ($s - [Math]::PI)))
        }
    }
    $n *= 4;
}
