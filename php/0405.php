# �㏸�K��p
function RisingFact($x, $n)
{
    if ($n <= 1)
        return $x;
    else
        return $x * RisingFact($x + 1, $n - 1);
}

# 10 ���� 14 �܂ł� ����
echo RisingFact(10, 5), "\n";
echo 10 * 11 * 12 * 13 * 14, "\n";
