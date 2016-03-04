# 重力加速度
$g = -9.8
# 空気抵抗係数
$k = -0.01
# 時間間隔(秒)
$h = 0.01

# 角度
$degree = 45
$radian = $degree * [Math]::PI / 180.0
# 初速 250 km/h -> 秒速に変換
$v = [math]::floor(250 * 1000 / 3600)
# 水平方向の速度
$vx  = New-Object double[] 2
$vx[0] = $v * [Math]::Cos($radian)
# 鉛直方向の速度
$vy  = New-Object double[] 2
$vy[0] = $v * [Math]::Sin($radian)
# 経過秒数
$t = 0.0
# 位置
$x = 0.0
$y = 0.0

# 空気抵抗による水平方向の減速分
function fx($vx, $vy)
{
    return $global:k * [Math]::Sqrt($vx * $vx + $vy * $vy) * $vx
}
# 重力と空気抵抗による鉛直方向の減速分
function fy($vx, $vy)
{
    return $global:g + ($global:k * [Math]::Sqrt($vx * $vx + $vy * $vy) * $vy)
}

# Euler法
for ($i = 1; $y -ge 0.0; $i++)
{
    # 経過秒数
    $t = $i * $h

    # 位置
    $x += $h * $vx[0]
    $y += $h * $vy[0]

    Write-Host ([string]::format("{0,4:F2}`t{1,8:F5}`t{2,9:F5}`t{3,9:F5}`t{4,8:F5}", $t, $vx[0], $vy[0], $x, $y))

    # 速度
    $vx[1] = $vx[0] + $h * (fx $vx[0] $vy[0])
    $vy[1] = $vy[0] + $h * (fy $vx[0] $vy[0])
    $vx[0] = $vx[1]
    $vy[0] = $vy[1]
}
