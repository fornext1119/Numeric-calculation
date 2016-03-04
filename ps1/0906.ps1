function secant($x0, $x1)
{
	while ($true)
	{
		$x2 = $x1 - (f $x1) * ($x1 - $x0) / ((f $x1) - (f $x0))
	    Write-Host ([string]::format("{0,12:F10}`t{1,13:F10}", $x2, $x2 - [Math]::Sqrt(2)))

	    if ([Math]::Abs($x2 - $x1) -lt 0.0000000001)
	    {
	        break
	    }
	    $x0 = $x1
	    $x1 = $x2
	}
	return $x2
}

function f($x)
{
    return $x * $x - 2
}

$x0 = 1
$x1 = 2
Write-Host ([string]::format("{0,12:F10}", (secant $x0 $x1)))
