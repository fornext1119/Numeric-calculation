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

# �g���� (�قȂ� 10 �̂��̂��� 5 ����Ăł���g�����̑���)
$n = 10
$r = 5
Write-Host (Comb $n $r)
