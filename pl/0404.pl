# ���~�K��p
sub FallingFact
{
    my ($x, $n) = @_;

    if ($n <= 1)
    {
        $x;
    }
    else
    {
        $x * FallingFact($x - 1, $n - 1);
    }
}

# 10 ���� 6 �܂ł� ����
print FallingFact(10, 5), "\n";
print 10 * 9 * 8 * 7 * 6, "\n";
