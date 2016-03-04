# ŠKæ
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

# ‰º~ŠKæ™p
function FallingFact($x, $n)
{
    if ($n -le 1)
    {
        $x
    }
    else
    {
        $x * (FallingFact ($x - 1) ($n - 1))
    }
}

# ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
$n = 10
$r = 5
Write-Host ((Fact $n) / (Fact ($n - $r)))
Write-Host (FallingFact $n $r)
