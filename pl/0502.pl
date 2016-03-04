use Math::Trig qw'deg2rad tan';

# ����̗]���֐�
sub myCos
{
    my ($x, $n, $nega, $numerator, $denominator, $y) = @_;

    $m           = 2 * $n;
    $denominator = $denominator * $m * ($m - 1);
    $numerator   = $numerator * $x * $x;
    $a           = $numerator / $denominator;
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if ($a <= 0.00000000001)
    {
        $y;
    }
    else
    {
        $y + myCos($x, ++$n, !$nega, $numerator, $denominator, $nega ? $a : -$a);
    }
}

for $i (0..24)
{
    $degree = $i * 15;
    if ($degree % 30 == 0 || $degree % 45 == 0)
    {
        $radian = deg2rad($degree);
        # ����̗]���֐�
        $d1     = myCos($radian, 1, 0, 1.0, 1.0, 1.0);
        # �W���̗]���֐�
        $d2     = cos($radian);
        # �W���֐��Ƃ̍���
        printf("%3d : %13.10f - %13.10f = %13.10f\n", $degree, $d1, $d2, $d1 - $d2);
    }
}
