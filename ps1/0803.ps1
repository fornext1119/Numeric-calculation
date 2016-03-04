# �d�͉����x
$g = -9.8
# ��C��R�W��
$k = -0.01
# ���ԊԊu(�b)
$h = 0.01

# �p�x
$degree = 45
$radian = $degree * [Math]::PI / 180.0
# ���� 250 km/h -> �b���ɕϊ�
$v = [math]::floor(250 * 1000 / 3600)
# ���������̑��x
$vx  = New-Object double[] 2
$vx[0] = $v * [Math]::Cos($radian)
# ���������̑��x
$vy  = New-Object double[] 2
$vy[0] = $v * [Math]::Sin($radian)
# �o�ߕb��
$t = 0.0
# �ʒu
$x  = New-Object double[] 2
$y  = New-Object double[] 2
$x[0] = 0.0
$y[0] = 0.0

# ��C��R�ɂ�鐅�������̌�����
function fx($vx, $vy)
{
    return $global:k * [Math]::Sqrt($vx * $vx + $vy * $vy) * $vx
}
# �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
function fy($vx, $vy)
{
    return $global:g + ($global:k * [Math]::Sqrt($vx * $vx + $vy * $vy) * $vy)
}

# ���_�@
for ($i = 1; $y[0] -ge 0.0; $i++)
{
    # �o�ߕb��
    $t = $i * $h

    # �ʒu�E���x
    $vx[1] = $h * (fx $vx[0] $vy[0])
    $vy[1] = $h * (fy $vx[0] $vy[0])
    
    $wx    = $vx[0] + $vx[1] / 2
    $wy    = $vy[0] + $vy[1] / 2
    $vx[0] = $vx[0] + $h * (fx $wx $wy)
    $vy[0] = $vy[0] + $h * (fy $wx $wy)
    $x[0]  =  $x[0] + $h *     $wx
    $y[0]  =  $y[0] + $h *     $wy

    Write-Host ([string]::format("{0,4:F2}`t{1,8:F5}`t{2,9:F5}`t{3,9:F5}`t{4,8:F5}", $t, $vx[0], $vy[0], $x[0], $y[0]))
}