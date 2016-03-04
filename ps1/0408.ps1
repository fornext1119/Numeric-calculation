# ‘g‡‚¹
function Comb($n, $r)
{
    if (($r -eq 0) -or ($r -eq $n))
    {
        1
    }
    elseif ($r -eq 1)
    {
        $n
    }
    else
    {
        (Comb ($n - 1) ($r - 1)) + (Comb ($n - 1) $r)
    }
}

# ‘g‡‚¹ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‘g‡‚¹‚Ì‘”)
$n = 10
$r = 5
Write-Host (Comb $n $r)
