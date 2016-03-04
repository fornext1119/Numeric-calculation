# ����̑ΐ��֐�
function myLog($x, $n, $t)
{
    $n2 = $n
    $x2 = $x
    if ($n -gt 3)
    {
        if ($n % 2 -eq 0)
        {
            $n2 = 2
        }
        $x2 = $x * [Math]::Floor($n / 2)
    }
    $t = $x2 / ($n2 + $t)

    if ($n -le 2)
    {
        $x / (1 + $t)
    }
    else
    {
        myLog $x ($n - 1) $t
    }
}

foreach ($i in 1..20)
{
    $x = $i / 5.0
    # �W���̑ΐ��֐�
    $d1 = [Math]::Log($x)
    # ����̑ΐ��֐�
    $d2 = myLog ($x - 1) 27 0.0 # 27:�K�v�Ȑ��x��������\���傫�Ȋ
    # �W���֐��Ƃ̍���
    Write-Host ([string]::format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", $x, $d1, $d2, $d1 - $d2))
}
