<?php
$a = 0;
$b = 1;

# ’†“_‘¥‚ÅÏ•ª
$n = 2;
foreach (range(1, 10) as $j)
{
    $h = ($b - $a) / $n;
    $s = 0;
    $x = $a + ($h / 2);
    foreach (range(1, $n) as $i)
    {
        $s += f($x);
        $x += $h;
    }
    $s *= $h;
    $n *= 2;

    # Œ‹‰Ê‚ð ƒÎ ‚Æ”äŠr
    printf("%2d : %13.10f, %13.10f\n", $j, $s, $s - M_PI);
}

function f($x)
{
    return 4 / (1 + $x * $x);
}
?>
