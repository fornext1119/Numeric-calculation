# ����̑o�Ȑ��]���֐�
function myCosh($x, $n, $numerator, $denominator, $y)
{
    $m           = 2 * $n
    $denominator = $denominator * $m * ($m - 1)
    $numerator   = $numerator   * $x * $x
    $a           = $numerator / $denominator
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if ([Math]::Abs($a) -le 0.00000000001) 
    {
        $y
    }
    else
    {
        $y + (myCosh $x ($n + 1) $numerator $denominator $a)
    }
}

foreach ($i in 0..20)
{
    $x = $i - 10
    # ����̑o�Ȑ��]���֐�
    $d1 = myCosh $x 1 1.0 1.0 1.0
    # �W���̑o�Ȑ��]���֐�
    $d2 = [Math]::Cosh($x)
    # �W���֐��Ƃ̍���
    Write-Host ([string]::format("{0,3:D} : {1,17:F10} - {2,17:F10} = {3,13:F10}", $x, $d1, $d2, $d1 - $d2))
}
