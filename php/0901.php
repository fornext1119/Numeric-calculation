<?php
$a = 1;
$b = 2;
printf("%12.10f\n", bisection($a, $b));

function bisection($a, $b)
{
	while (TRUE)
	{
	    # 区間 (a, b) の中点 c = (a + b) / 2
	    $c = ($a + $b) / 2;
	    printf("%12.10f\t%13.10f\n", $c, $c - sqrt(2));

	    $fc = f($c);
	    if (abs($fc) < 0.0000000001) break;

	    if ($fc < 0)
	    {
	        # f(c) < 0 であれば, 解は区間 (c, b) の中に存在
	        $a = $c;
	    }
	    else
	    {
	        # f(c) > 0 であれば, 解は区間 (a, c) の中に存在
	        $b = $c;
	    }
	}
	return $c;
}

function f($x)
{
    return $x * $x - 2;
}
?>
