function bailey($x0)
{
	while ($true)
	{
	    $x1 = $x0 - ((f0 $x0) / ((f1 $x0) - ((f0 $x0) * (f2 $x0) / (2 * (f1 $x0)))))
	    Write-Host ([string]::format("{0,12:F10}`t{1,13:F10}", $x1, $x1 - [Math]::Sqrt(2)))

	    if ([Math]::Abs($x1 - $x0) -lt 0.0000000001)
	    {
	        break
	    }
	    $x0 = $x1
	}
	return $x1
}

function f0($x)
{
    return $x * $x - 2
}

function f1($x)
{
    return 2 * $x
}

function f2($x)
{
    return 2
}

$x = 2
Write-Host ([string]::format("{0,12:F10}", (bailey $x)))
