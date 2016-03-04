use Math::Trig 'pi';

# 重力加速度
my $g = -9.8;
# 空気抵抗係数
my $k = -0.01;
# 時間間隔(秒)
my $h = 0.01;

# 角度
my $degree = 45;
my $radian = $degree * pi / 180.0;
# 初速 250 km/h -> 秒速に変換
my $v = int(250 * 1000 / 3600);
# 水平方向の速度
my @vx = ();
$vx[0] = $v * cos($radian); 
# 鉛直方向の速度
my @vy = ();
$vy[0] = $v * sin($radian); 
# 経過秒数
my $t = 0.0;
# 位置
my @x = ();
$x[0] = 0.0;
my @y = ();
$y[0] = 0.0;

# 中点法
for (my $i = 1; $y[0] >= 0.0; $i++)
{
    # 経過秒数
    $t = $i * $h;

    # 位置・速度
    $vx[1] = $h * fx($vx[0], $vy[0]);
    $vy[1] = $h * fy($vx[0], $vy[0]);
    
    my $wx = $vx[0] + $vx[1] / 2;
    my $wy = $vy[0] + $vy[1] / 2;
    $vx[0] = $vx[0] + $h * fx($wx, $wy);
    $vy[0] = $vy[0] + $h * fy($wx, $wy);
    $x[0]  =  $x[0] + $h *    $wx;
    $y[0]  =  $y[0] + $h *    $wy;

    printf("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%9.5f\n", $t, $vx[0], $vy[0], $x[0], $y[0]);
}

# 空気抵抗による水平方向の減速分
sub fx
{
  my ($vx, $vy) = @_;
    $k * sqrt($vx * $vx + $vy * $vy) * $vx;
}
# 重力と空気抵抗による鉛直方向の減速分
sub fy
{
	my ($vx, $vy) = @_;
    $g + ($k * sqrt($vx * $vx + $vy * $vy) * $vy);
}
