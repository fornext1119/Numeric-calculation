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
$x = array();
$x[0] = 0.0;
$y = array();
$y[0] = 0.0;

# Heun–@
for ($i = 1; $y[0] >= 0.0; $i++)
{
    # Œo‰ß•b”
    $t = $i * $h;

    # ˆÊ’uE‘¬“x
    $x[1]  =  $x[0] + $h *    $vx[0];
    $y[1]  =  $y[0] + $h *    $vy[0];
    $vx[1] = $vx[0] + $h * fx($vx[0], $vy[0]);
    $vy[1] = $vy[0] + $h * fy($vx[0], $vy[0]);

    $x[2]  =  $x[0] + $h * (   $vx[0]          +    $vx[1]         ) / 2;
    $y[2]  =  $y[0] + $h * (   $vy[0]          +    $vy[1]         ) / 2;
    $vx[2] = $vx[0] + $h * (fx($vx[0], $vy[0]) + fx($vx[1], $vy[1])) / 2;
    $vy[2] = $vy[0] + $h * (fy($vx[0], $vy[0]) + fy($vx[1], $vy[1])) / 2;

    $x[0]  =  $x[2];
    $y[0]  =  $y[2];
    $vx[0] = $vx[2];
    $vy[0] = $vy[2];

    printf("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f\n", $t, $vx[0], $vy[0], $x[0], $y[0]);
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
