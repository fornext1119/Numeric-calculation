<?php

# d—Í‰Á‘¬“x
$g = -9.8;
# ‹ó‹C’ïRŒW”
$k = -0.01;
# ŽžŠÔŠÔŠu(•b)
$h = 0.01;

# Šp“x
$degree = 45;
$radian = $degree * M_PI / 180.0;
# ‰‘¬ 250 km/h -> •b‘¬‚É•ÏŠ·
$v = (int)(250 * 1000 / 3600);
# …•½•ûŒü‚Ì‘¬“x
$vx = array();
$vx[0] = $v * cos($radian); 
# ‰”’¼•ûŒü‚Ì‘¬“x
$vy = array();
$vy[0] = $v * sin($radian); 
# Œo‰ß•b”
$t = 0.0;
# ˆÊ’u
$x = 0.0;
$y = 0.0;

# Euler–@
for ($i = 1; $y >= 0.0; $i++)
{
    # Œo‰ß•b”
    $t = $i * $h;

    # ˆÊ’u
    $x += $h * $vx[0];
    $y += $h * $vy[0];

    printf("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f\n", $t, $vx[0], $vy[0], $x, $y);

    # ‘¬“x
    $vx[1] = $vx[0] + $h * fx($vx[0], $vy[0]);
    $vy[1] = $vy[0] + $h * fy($vx[0], $vy[0]);
    $vx[0] = $vx[1];
    $vy[0] = $vy[1];
}

# ‹ó‹C’ïR‚É‚æ‚é…•½•ûŒü‚ÌŒ¸‘¬•ª
function fx($vx, $vy)
{
    global $k;
    return $k * sqrt($vx * $vx + $vy * $vy) * $vx;
}
# d—Í‚Æ‹ó‹C’ïR‚É‚æ‚é‰”’¼•ûŒü‚ÌŒ¸‘¬•ª
function fy($vx, $vy)
{
    global $g, $k;
    return $g + ($k * sqrt($vx * $vx + $vy * $vy) * $vy);
}
?>
