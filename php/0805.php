<?php

# 重力加速度
$g = -9.8;
# 空気抵抗係数
$k = -0.01;
# 時間間隔(秒)
$h = 0.01;

# 角度
$degree = 45;
$radian = $degree * M_PI / 180.0;
# 初速 250 km/h -> 秒速に変換
$v = (int)(250 * 1000 / 3600);
# 水平方向の速度
$vx = array();
$vx[0] = $v * cos($radian); 
# 鉛直方向の速度
$vy = array();
$vy[0] = $v * sin($radian); 
# 経過秒数
$t = 0.0;
# 位置
$x = array();
$x[0] = 0.0;
$y = array();
$y[0] = 0.0;

# Runge-Kutta-Gill法
for ($i = 1; $y[0] >= 0.0; $i++)
{
    # 経過秒数
    $t = $i * $h;

    # 位置・速度
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

# 空気抵抗による水平方向の減速分
function fx($vx, $vy)
{
    global $k;
    return $k * sqrt($vx * $vx + $vy * $vy) * $vx;
}
# 重力と空気抵抗による鉛直方向の減速分
function fy($vx, $vy)
{
    global $g, $k;
    return $g + ($k * sqrt($vx * $vx + $vy * $vy) * $vy);
}
?>
