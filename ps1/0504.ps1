# ����̎w���֐�
function myExp($x, $n, $numerator, $denominator, $y)
{
    $denominator = $denominator * $n
    $numerator   = $numerator   * $x
    $a           = $numerator / $denominator
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if ([Math]::Abs($a) -le 0.00000000001)
    {
        $y
    }
    else
    {
        $y + (myExp $x ($n + 1) $numerator $denominator $a)
    }
}

foreach ($i in 0..20)
{
    $x = ($i - 10) / 4.0
    # �W���̎w���֐�
    $d1 = [Math]::Exp($x)
    # ����̎w���֐�
    $d2 = myExp $x 1 1.0 1.0 1.0
    # �W���֐��Ƃ̍���
    Write-Host ([string]::format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", $x, $d1, $d2, $d1 - $d2))
}
