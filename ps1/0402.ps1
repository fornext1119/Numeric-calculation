# ‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ‚ğ•\¦‚·‚é
Write-Host (product 5 3 10)

function product($m, $d, $n)
{
    if ($n -eq 0)
    {
        1
    }
    else
    {
        $m * (product ($m + $d) $d ($n - 1))
    }
}
