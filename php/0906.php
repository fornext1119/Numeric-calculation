<?php
$x0 = 1;
$x1 = 2;
printf("%12.10f\n", secant($x0, $x1));

function secant($x0, $x1)
{
	while (TRUE)
	{
	    $x2 = $x1 - f($x1) * ($x1 - $x0) / (f($x1) - f($x0));
	    printf("%12.10f\t%13.10f\n", $x2, $x2 - sqrt(2));

	    if (abs($x2 - $x1) < 0.0000000001) break;

	    $x0 = $x1;
	    $x1 = $x2;
	}
	return $x2;
}

function f($x)
{
    return $x * $x - 2;
}
?>
