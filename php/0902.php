<?php
$a = 1;
$b = 2;
printf("%12.10f\n", falseposition($a, $b));

function falseposition($a, $b)
{
	while (TRUE)
	{
	    # �_ (a,f(a)) �� �_ (b,f(b)) �����Ԓ����� x���̌�_
	    $c = ($a * f($b) - $b * f($a)) / (f($b) - f($a));
	    printf("%12.10f\t%13.10f\n", $c, $c - sqrt(2));

	    $fc = f($c);
	    if (abs($fc) < 0.0000000001) break;

	    if ($fc < 0)
	    {
	        # f(c) < 0 �ł����, ���͋�� (c, b) �̒��ɑ���
	        $a = $c;
	    }
	    else
	    {
	        # f(c) > 0 �ł����, ���͋�� (a, c) �̒��ɑ���
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
