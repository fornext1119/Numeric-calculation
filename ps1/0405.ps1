# �㏸�K��p
function RisingFact($x, $n)
{
    if ($n -le 1)
    {
        $x
    }
    else
    {
        $x * (RisingFact ($x + 1) ($n - 1))
    }
}

# 10 ���� 14 �܂ł� ����
Write-Host (RisingFact 10 5)
Write-Host (10 * 11 * 12 * 13 * 14)
