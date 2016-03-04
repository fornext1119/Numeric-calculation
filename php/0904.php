<?php
$x = 2;
printf("%12.10f\n", newton($x));

function newton($x0)
{
	while (TRUE)
	{
	    $x1 = $x0 - (f0($x0) / f1($x0));
	    printf("%12.10f\t%13.10f\n", $x1, $x1 - sqrt(2));

	    if (abs($x1 - $x0) < 0.0000000001) break;

	    $x0 = $x1;
	}
	return $x1;
}

function f0($x)
{
    return $x * $x - 2;
}

function f1($x)
{
    return 2 * $x;
}
?>
