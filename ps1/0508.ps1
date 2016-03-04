# ����̑o�Ȑ������֐�
function mySinh($x, $n, $numerator, $denominator, $y)
{
    $m           = 2 * $n
    $denominator = $denominator * ($m + 1) * $m
    $numerator   = $numerator   * $x * $x
    $a           = $numerator / $denominator
    # �\���Ȑ��x�ɂȂ����珈���𔲂���
    if ([Math]::Abs($a) -le 0.00000000001) 
    {
        $y
    }
    else
    {
        $y + (mySinh $x ($n + 1) $numerator $denominator $a)
    }
}

foreach ($i in 0..20)
{
    $x = $i - 10
    # ����̑o�Ȑ������֐�
    $d1 = mySinh $x 1 $x 1.0 $x
    # �W���̑o�Ȑ������֐�
    $d2 = [Math]::Sinh($x)
    # �W���֐��Ƃ̍���
    Write-Host ([string]::format("{0,3:D} : {1,17:F10} - {2,17:F10} = {3,13:F10}", $x, $d1, $d2, $d1 - $d2))
}
