# ���~�K��p
function FallingFact($x, $n)
{
    if ($n -le 1)
    {
        $x
    }
    else
    {
        $x * (FallingFact ($x - 1) ($n - 1))
    }
}

# 10 ���� 6 �܂ł� ����
Write-Host (FallingFact 10 5)
Write-Host (10 * 9 * 8 * 7 * 6)
