<?php
# Ž©ì‚Ì‘o‹Èü³Œ·ŠÖ”
function mySinh($x, $n, $numerator, $denominator, $y)
{
    $m           = 2 * $n;
    $denominator = $denominator * ($m + 1) * $m;
    $numerator   = $numerator * $x * $x;
    $a           = $numerator / $denominator;

    # \•ª‚È¸“x‚É‚È‚Á‚½‚çˆ—‚ð”²‚¯‚é
    if (abs($a) <= 0.00000000001)
        return $y;
    else
        return $y + mySinh($x, ++$n, $numerator, $denominator, $a);
}

foreach (range(0, 20) as $i)
{
    $x  = $i - 10;
    # Ž©ì‚Ì‘o‹Èü³Œ·ŠÖ”
    $d1 = mySinh($x, 1, $x, 1.0, $x);
    # •W€‚Ì‘o‹Èü³Œ·ŠÖ”
    $d2 = sinh($x);
    # •W€ŠÖ”‚Æ‚Ì·ˆÙ
    printf("%3d : %17.10f - %17.10f = %13.10f\n", $x, $d1, $d2, $d1 - $d2);
}
?>
