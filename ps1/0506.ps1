# ����̑ΐ��֐�
function myLog($x2, $numerator, $denominator, $y)
{
    $denominator = $denominator + 2
    $numerator   = $numerator   * $x2 * $x2
    $a           = $numerator / $denominator
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if ([Math]::Abs($a) -le 0.00000000001)
    {
        $y
    }
    else
    {
        $y + (myLog $x2 $numerator $denominator $a)
    }
}

foreach ($i in 1..20)
{
    $x = $i / 5.0
    # �W���̑ΐ��֐�
    $d1 = [Math]::Log($x)
    # ����̑ΐ��֐�
    $x2 = ($x - 1) / ($x + 1)
    $d2 = 2 * (myLog $x2 $x2 1.0 $x2)
    # �W���֐��Ƃ̍���
    Write-Host ([string]::format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", $x, $d1, $d2, $d1 - $d2))
}
