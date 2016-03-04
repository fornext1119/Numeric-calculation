<?php
$x = 1;
printf("%12.10f\n", iterative($x));

function iterative($x0)
{
	while (TRUE)
	{
	    $x1 = g($x0);
	    printf("%12.10f\t%13.10f\n", $x1, $x1 - sqrt(2));

	    if (abs($x1 - $x0) < 0.0000000001) break;

	    $x0 = $x1;
	}
	return $x1;
}

function g($x)
{
    return ($x / 2) + (1 / $x);
}
?>
