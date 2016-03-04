# ŠKæ
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

# ‰º~ŠKæ™p
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

# ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
$n = 10;
$r = 5;
print Fact($n) / Fact($n - $r), "\n";
print FallingFact($n, $r), "\n";
