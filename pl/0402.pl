sub product
{
    my ($m, $d, $n) = @_;
    if ($n == 0)
    {
        1
    }
    else
    {
        $m * product($m + $d, $d, $n - 1)
    }
}

# ‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ‚ğ•\¦‚·‚é
print product(5, 3, 10);
