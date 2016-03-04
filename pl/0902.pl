my $a = 1;
my $b = 2;
printf("%12.10f\n", falseposition($a, $b));

sub falseposition
{
    my ($a, $b) = @_;
    my $c;
	while (1)
	{
	    # �_ (a,f(a)) �� �_ (b,f(b)) �����Ԓ����� x���̌�_
	    $c = ($a * f($b) - $b * f($a)) / (f($b) - f($a));
	    printf("%12.10f\t%13.10f\n", $c, $c - sqrt(2));

	    my $fc = f($c);
	    if (abs($fc) < 0.0000000001)
	    {
	        last;
	    }

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
	$c;
}

sub f
{
    my ($x) = @_;
    $x * $x - 2;
}
