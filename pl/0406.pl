# 階乗
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

# 下降階乗冪
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

# 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
$n = 10;
$r = 5;
print Fact($n) / Fact($n - $r), "\n";
print FallingFact($n, $r), "\n";
