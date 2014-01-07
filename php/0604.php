<?php
$a = 0;
$b = 1;

$t = array();

# ‘äŒ`‘¥‚ÅÏ•ª
$n = 2;
foreach (range(1, 6) as $i)
{
    $h = ($b - $a) / $n;
    $s = 0;
    $x = $a;
    foreach (range(1, ($n - 1)) as $j)
    {
        $x += $h;
        $s += f($x);
    }
    # Œ‹‰Ê‚ð•Û‘¶
    $t[$i][1] = $h * ((f($a) + f($b)) / 2 + $s);
    $n *= 2;
}

# Richardson‚Ì•âŠO–@
$n = 4;
foreach (range(2, 6) as $j)
{
    foreach (range($j, 6) as $i)
    {
        $t[$i][$j] = $t[$i][$j - 1] + ($t[$i][$j - 1] - $t[$i - 1][$j - 1]) / ($n - 1);
        if ($i == $j)
        {
            # Œ‹‰Ê‚ð ƒÎ ‚Æ”äŠr
            printf("%2d : %13.10f, %13.10f\n", $j, $t[$i][$j], $t[$i][$j] - M_PI);
        }
    }
    $n *= 4;
}

function f($x)
{
    return 4 / (1 + $x * $x);
}
?>
