use Math::Trig;

# ����̑o�Ȑ������֐�
sub mySinh
{
    my ($x, $n, $numerator, $denominator, $y) = @_;

    $m           = 2 * $n;
    $denominator = $denominator * ($m + 1) * $m;
    $numerator   = $numerator * $x * $x;
    $a           = $numerator / $denominator;

    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (abs($a) <= 0.00000000001)
    {
        $y;
    }
    else
    {
        $y + mySinh($x, ++$n, $numerator, $denominator, $a);
    }
}

for $i (0..20)
{
    $x  = $i - 10;
    # ����̑o�Ȑ������֐�
    $d1 = mySinh($x, 1, $x, 1.0, $x);
    # �W���̑o�Ȑ������֐�
    $d2 = sinh($x);
    # �W���֐��Ƃ̍���
    printf("%3d : %17.10f - %17.10f = %13.10f\n", $x, $d1, $d2, $d1 - $d2);
}
