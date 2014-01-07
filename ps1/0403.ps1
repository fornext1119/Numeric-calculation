# ŠKæ‚ğ‹‚ß‚éŠÖ”
function Fact($n)
{
    if ($n -le 1)
    {
        1
    }
    else
    {
        $n * (Fact ($n - 1))
    }
}

# 10‚ÌŠKæ
Write-Host (Fact(10))
Write-Host (10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1)
