# ŠKæ‚ğ‹‚ß‚éŠÖ”
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

# 10‚ÌŠKæ
print Fact(10), "\n";
print 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1, "\n";
