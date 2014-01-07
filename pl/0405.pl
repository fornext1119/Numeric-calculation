# ã¸ŠKæ™p
sub RisingFact
{
    my ($x, $n) = @_;

    if ($n <= 1)
    {
        $x;
    }
    else
    {
        $x * RisingFact($x + 1, $n - 1);
    }
}

# 10 ‚©‚ç 14 ‚Ü‚Å‚Ì ‘æ
print RisingFact(10, 5), "\n";
print 10 * 11 * 12 * 13 * 14, "\n";
