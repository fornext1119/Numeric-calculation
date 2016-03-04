function falseposition($a, $b)
{
	while ($true)
	{
	    # �_ (a,f(a)) �� �_ (b,f(b)) �����Ԓ����� x���̌�_
	    $c = ($a * (f $b) - $b * (f $a)) / ((f $b) - (f $a))
	    Write-Host ([string]::format("{0,12:F10}`t{1,13:F10}", $c, $c - [Math]::Sqrt(2)))

	    $fc = f($c)
	    if ([Math]::Abs($fc) -lt 0.0000000001)
	    {
	        break
	    }

	    if ($fc -lt 0)
	    {
	        # f(c) < 0 �ł����, ���͋�� (c, b) �̒��ɑ���
	        $a = $c
	    }
	    else
	    {
	        # f(c) > 0 �ł����, ���͋�� (a, c) �̒��ɑ���
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
Write-Host ([string]::format("{0,12:F10}", (falseposition $a $b)))
