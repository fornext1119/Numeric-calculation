<?php

# �d�͉����x
$g = -9.8;
# ��C��R�W��
$k = -0.01;
# ���ԊԊu(�b)
$h = 0.01;

# �p�x
$degree = 45;
$radian = $degree * M_PI / 180.0;
# ���� 250 km/h -> �b���ɕϊ�
$v = (int)(250 * 1000 / 3600);
# ���������̑��x
$vx = array();
$vx[0] = $v * cos($radian); 
# ���������̑��x
$vy = array();
$vy[0] = $v * sin($radian); 
# �o�ߕb��
$t = 0.0;
# �ʒu
$x = array();
$x[0] = 0.0;
$y = array();
$y[0] = 0.0;

# ���_�@
for ($i = 1; $y[0] >= 0.0; $i++)
{
    # �o�ߕb��
    $t = $i * $h;

    # �ʒu�E���x
    $vx[1] = $h * fx($vx[0], $vy[0]);
    $vy[1] = $h * fy($vx[0], $vy[0]);
    
    $wx = $vx[0] + $vx[1] / 2;
    $wy = $vy[0] + $vy[1] / 2;
    $vx[0] = $vx[0] + $h * fx($wx, $wy);
    $vy[0] = $vy[0] + $h * fy($wx, $wy);
    $x[0]  =  $x[0] + $h *    $wx;
    $y[0]  =  $y[0] + $h *    $wy;

    printf("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%9.5f\n", $t, $vx[0], $vy[0], $x[0], $y[0]);
}

# ��C��R�ɂ�鐅�������̌�����
function fx($vx, $vy)
{
    global $k;
    return $k * sqrt($vx * $vx + $vy * $vy) * $vx;
}
# �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
function fy($vx, $vy)
{
    global $g, $k;
    return $g + ($k * sqrt($vx * $vx + $vy * $vy) * $vy);
}
?>
