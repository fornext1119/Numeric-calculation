# �K��
sub Fact
{
    my ($n) = @_;

    if ($n <= 1)
    {
        1;
    }
    else
    {
        $n * Fact($n - 1);
    }
}

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

# ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
$n = 10;
$r = 5;
print Fact($n) / Fact($n - $r), "\n";
print FallingFact($n, $r), "\n";
