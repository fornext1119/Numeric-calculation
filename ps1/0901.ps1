function bisection($a, $b)
{
	while ($true)
	{
	    # 区間 (a, b) の中点 c = (a + b) / 2
	    $c = ($a + $b) / 2
	    Write-Host ([string]::format("{0,12:F10}`t{1,13:F10}", $c, $c - [Math]::Sqrt(2)))

	    $fc = f($c)
	    if ([Math]::Abs($fc) -lt 0.0000000001)
	    {
	        break
	    }

	    if ($fc -lt 0)
	    {
	        # f(c) < 0 であれば, 解は区間 (c, b) の中に存在
	        $a = $c
	    }
	    else
	    {
	        # f(c) > 0 であれば, 解は区間 (a, c) の中に存在
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
