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

# Heun法
for ($i = 1; $y[0] >= 0.0; $i++)
{
    # 経過秒数
    $t = $i * $h;

    # 位置・速度
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
