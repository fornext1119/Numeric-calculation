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

# Runge-Kutta-Gill–@
for ($i = 1; $y[0] >= 0.0; $i++)
{
    # Œo‰ß•b”
    $t = $i * $h;

    # ˆÊ’uE‘¬“x
    $x[1]  = $h *    $vx[0];
    $y[1]  = $h *    $vy[0];
    $vx[1] = $h * fx($vx[0], $vy[0]);
    $vy[1] = $h * fy($vx[0], $vy[0]);

    $wx = $vx[0] + $vx[1] / 2;
    $wy = $vy[0] + $vy[1] / 2;
    $x[2]  = $h *    $wx;
    $y[2]  = $h *    $wy;
    $vx[2] = $h * fx($wx, $wy);
    $vy[2] = $h * fy($wx, $wy);

    $wx    = $vx[0] + $vx[1] * ((sqrt(2.0) - 1) / 2) + $vx[2] * (1 - 1 / sqrt(2.0));
    $wy    = $vy[0] + $vy[1] * ((sqrt(2.0) - 1) / 2) + $vy[2] * (1 - 1 / sqrt(2.0));
    $x[3]  = $h *    $wx;
    $y[3]  = $h *    $wy;
    $vx[3] = $h * fx($wx, $wy);
    $vy[3] = $h * fy($wx, $wy);

    $wx    = $vx[0] - $vx[2] / sqrt(2.0) + $vx[3] * (1 + 1 / sqrt(2.0));
    $wy    = $vy[0] - $vy[2] / sqrt(2.0) + $vy[3] * (1 + 1 / sqrt(2.0));
    $x[4]  = $h *    $wx;
    $y[4]  = $h *    $wy;
    $vx[4] = $h * fx($wx, $wy);
    $vy[4] = $h * fy($wx, $wy);

    $x[0]  += ( $x[1] +  $x[2] * (2 - sqrt(2.0)) +  $x[3] * (2 + sqrt(2.0)) +  $x[4]) / 6;
    $y[0]  += ( $y[1] +  $y[2] * (2 - sqrt(2.0)) +  $y[3] * (2 + sqrt(2.0)) +  $y[4]) / 6;
    $vx[0] += ($vx[1] + $vx[2] * (2 - sqrt(2.0)) + $vx[3] * (2 + sqrt(2.0)) + $vx[4]) / 6;
    $vy[0] += ($vy[1] + $vy[2] * (2 - sqrt(2.0)) + $vy[3] * (2 + sqrt(2.0)) + $vy[4]) / 6;

    printf("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%9.5f\n", $t, $vx[0], $vy[0], $x[0], $y[0]);
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
