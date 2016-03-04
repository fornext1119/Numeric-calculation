# ����̑ΐ��֐�
sub myLog
{
    my ($x2, $numerator, $denominator, $y) = @_;

    $denominator = $denominator + 2;
    $numerator   = $numerator   * $x2 * $x2;
    $a           = $numerator / $denominator;
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (abs($a) <= 0.00000000001)
    {
        $y;
    }
    else
    {
        $y + myLog($x2, $numerator, $denominator, $a);
    }
}

for $i (1..20)
{
    $x  = $i / 5.0;
    # �W���̑ΐ��֐�
    $d1 = log($x);
    # ����̑ΐ��֐�
    $x2 = ($x - 1) / ($x + 1);  
    $d2 = 2 * myLog($x2, $x2, 1.0, $x2);
    # �W���֐��Ƃ̍���
    printf("%5.2f : %13.10f - %13.10f = %13.10f\n", $x, $d1, $d2, $d1 - $d2);
}
