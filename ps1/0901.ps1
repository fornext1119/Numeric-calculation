function bisection($a, $b)
{
	while ($true)
	{
	    # ‹æŠÔ (a, b) ‚Ì’†“_ c = (a + b) / 2
	    $c = ($a + $b) / 2
	    Write-Host ([string]::format("{0,12:F10}`t{1,13:F10}", $c, $c - [Math]::Sqrt(2)))

	    $fc = f($c)
	    if ([Math]::Abs($fc) -lt 0.0000000001)
	    {
	        break
	    }

	    if ($fc -lt 0)
	    {
	        # f(c) < 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (c, b) ‚Ì’†‚É‘¶İ
	        $a = $c
	    }
	    else
	    {
	        # f(c) > 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (a, c) ‚Ì’†‚É‘¶İ
	        $b = $c
	    }
	}
	return $c
}

function f($x)
{
    return $x * $x - 2
}

$a = 1
$b = 2
Write-Host ([string]::format("{0,12:F10}", (bisection $a $b)))
