use Math::Trig;

# ����̑o�Ȑ��]���֐�
sub myCosh
{
    my ($x, $n, $numerator, $denominator, $y) = @_;

    $m           = 2 * $n;
    $denominator = $denominator * $m * ($m - 1);
    $numerator   = $numerator * $x * $x;
    $a           = $numerator / $denominator;

    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (abs($a) <= 0.00000000001)
    {
        $y;
    }
    else
    {
        $y + myCosh($x, ++$n, $numerator, $denominator, $a);
    }
}

for $i (0..20)
{
    $x  = $i - 10;
    # ����̑o�Ȑ��]���֐�
    $d1 = myCosh($x, 1, 1.0, 1.0, 1.0);
    # �W���̑o�Ȑ��]���֐�
    $d2 = cosh($x);
    # �W���֐��Ƃ̍���
    printf("%3d : %17.10f - %17.10f = %13.10f\n", $x, $d1, $d2, $d1 - $d2);
}
