<?php
$a = 0;
$b = 1;

# ‘äŒ`‘¥‚ÅÏ•ª
$n = 2;
foreach (range(1, 10) as $j)
{
    $h = ($b - $a) / $n;
    $s = 0;
    $x = $a;
    foreach (range(1, ($n - 1)) as $i)
    {
        $x += $h;
        $s += f($x);
    }
    $s = $h * ((f($a) + f($b)) / 2 + $s);
    $n *= 2;

    # Œ‹‰Ê‚ð ƒÎ ‚Æ”äŠr
    printf("%2d : %13.10f, %13.10f\n", $j, $s, $s - M_PI);
}

function f($x)
{
    return 4 / (1 + $x * $x);
}
?>
