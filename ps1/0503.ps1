# ����̐��ڊ֐�
function myTan($x, $x2, $n, $t)
{
    $t = $x2 / ($n - $t)
    $n -= 2

    if ($n -le 1)
    {
        $x / (1 - $t)
    }
    else
    {
        myTan $x $x2 $n $t
    }
}
foreach ($i in 0..12)
{
    if (($i * 15) % 180 -ne 0)
    {
        $degree = $i * 15 - 90
        $radian = $degree * [Math]::PI / 180.0
        $x2     = $radian * $radian
        # ����̐��ڊ֐�
        $d1     = myTan $radian $x2 15 0.0 # 15:�K�v�Ȑ��x��������\���傫�Ȋ
        # �W���̐��ڊ֐�
        $d2     = [Math]::Tan($radian)
        # �W���֐��Ƃ̍���
        Write-Host ([string]::format("{0,3:D} : {1,13:F10} - {2,13:F10} = {3,13:F10}", $degree, $d1, $d2, $d1 - $d2))
    }
}
