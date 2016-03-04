function iterative($x0)
{
	while ($true)
	{
	    $x1 = g($x0)
	    Write-Host ([string]::format("{0,12:F10}`t{1,13:F10}", $x1, $x1 - [Math]::Sqrt(2)))

	    if ([Math]::Abs($x1 - $x0) -lt 0.0000000001)
	    {
	        break
	    }
	    $x0 = $x1
	}
	return $x1
}

function g($x)
{
    return ($x / 2) + (1 / $x)
}

$x = 1
Write-Host ([string]::format("{0,12:F10}", (iterative $x)))
