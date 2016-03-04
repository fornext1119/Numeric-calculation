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
my $x = 0.0;
my $y = 0.0;

# Euler�@
for (my $i = 1; $y >= 0.0; $i++)
{
    # �o�ߕb��
    $t = $i * $h;

    # �ʒu
    $x += $h * $vx[0];
    $y += $h * $vy[0];

    printf("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f\n", $t, $vx[0], $vy[0], $x, $y);

    # ���x
    $vx[1] = $vx[0] + $h * fx($vx[0], $vy[0]);
    $vy[1] = $vy[0] + $h * fy($vx[0], $vy[0]);
    $vx[0] = $vx[1];
    $vy[0] = $vy[1];
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
