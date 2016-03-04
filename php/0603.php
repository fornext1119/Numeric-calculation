<?php
$a = 0;
$b = 1;

# Simpson‘¥‚ÅÏ•ª
$n = 2;
foreach (range(1, 5) as $j)
{
    $h  = ($b - $a) / $n;
    $s2 = 0;
    $s4 = 0;
    $x  = $a + $h;
    foreach (range(1, ($n / 2)) as $i)
    {
        $s4 += f($x);
        $x  += $h;
        $s2 += f($x);
        $x  += $h;
    }
    $s2 =  ($s2 - f($b)) * 2 + f($a) + f($b);
    $s4 *= 4;
    $s  =  ($s2 + $s4) * $h / 3;
    $n  *= 2;

    # Œ‹‰Ê‚ð ƒÎ ‚Æ”äŠr
    printf("%2d : %13.10f, %13.10f\n", $j, $s, $s - M_PI);
}

function f($x)
{
    return 4 / (1 + $x * $x);
}
?>
