use Math::Trig 'pi';

# �d�͉����x
my $g = -9.8;
# ��C��R�W��
my $k = -0.01;
# ���ԊԊu(�b)
my $h = 0.01;

# �p�x
my $degree = 45;
my $radian = $degree * pi / 180.0;
# ���� 250 km/h -> �b���ɕϊ�
my $v = int(250 * 1000 / 3600);
# ���������̑��x
my @vx = ();
$vx[0] = $v * cos($radian); 
# ���������̑��x
my @vy = ();
$vy[0] = $v * sin($radian); 
# �o�ߕb��
my $t = 0.0;
# �ʒu
my @x = ();
$x[0] = 0.0;
my @y = ();
$y[0] = 0.0;

# ���_�@
for (my $i = 1; $y[0] >= 0.0; $i++)
{
    # �o�ߕb��
    $t = $i * $h;

    # �ʒu�E���x
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

# ��C��R�ɂ�鐅�������̌�����
sub fx
{
  my ($vx, $vy) = @_;
    $k * sqrt($vx * $vx + $vy * $vy) * $vx;
}
# �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
sub fy
{
	my ($vx, $vy) = @_;
    $g + ($k * sqrt($vx * $vx + $vy * $vy) * $vy);
}
