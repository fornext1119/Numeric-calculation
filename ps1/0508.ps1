# ©ì‚Ì‘o‹Èü³Œ·ŠÖ”
function mySinh($x, $n, $numerator, $denominator, $y)
{
    $m           = 2 * $n
    $denominator = $denominator * ($m + 1) * $m
    $numerator   = $numerator   * $x * $x
    $a           = $numerator / $denominator
    # \•ª‚È¸“x‚É‚È‚Á‚½‚çˆ—‚ğ”²‚¯‚é
    if ([Math]::Abs($a) -le 0.00000000001) 
    {
        $y
    }
    else
    {
        $y + (mySinh $x ($n + 1) $numerator $denominator $a)
    }
}

foreach ($i in 0..20)
{
    $x = $i - 10
    # ©ì‚Ì‘o‹Èü³Œ·ŠÖ”
    $d1 = mySinh $x 1 $x 1.0 $x
    # •W€‚Ì‘o‹Èü³Œ·ŠÖ”
    $d2 = [Math]::Sinh($x)
    # •W€ŠÖ”‚Æ‚Ì·ˆÙ
    Write-Host ([string]::format("{0,3:D} : {1,17:F10} - {2,17:F10} = {3,13:F10}", $x, $d1, $d2, $d1 - $d2))
}
