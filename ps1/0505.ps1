# ����̎w���֐�
function myExp($x, $x2, $n, $t)
{
    $t = $x2 / ($n + $t)
    $n -= 4  

    if ($n -lt 6)
    {
        1 + ((2 * $x) / (2 - $x + $t))
    }
    else
    {
        myExp $x $x2 $n $t
    }
}

foreach ($i in 0..20)
{
    $x = ($i - 10) / 4.0
    # �W���̎w���֐�
    $d1 = [Math]::Exp($x)
    # ����̎w���֐�
    $x2 = $x * $x
    $d2 = myExp $x $x2 30 0.0 # 30:�K�v�Ȑ��x��������悤, 6����n�߂�4������������
    # �W���֐��Ƃ̍���
    Write-Host ([string]::format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", $x, $d1, $d2, $d1 - $d2))
}
