# �g����
function Comb($n, $r)
{
    if (($r -eq 0) -or ($r -eq $n))
    {
        1
    }
    elseif ($r -eq 1)
    {
        $n
    }
    else
    {
        (Comb ($n - 1) ($r - 1)) + (Comb ($n - 1) $r)
    }
}

# �d���g���� (�قȂ� 10 �̂��̂���d���������� 5 �Ƃ�g�����̑���)
$n = 10
$r = 5
Write-Host (Comb ($n + $r - 1) $r)
