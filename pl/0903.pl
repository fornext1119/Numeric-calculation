my $x = 1;
printf("%12.10f\n", iterative($x));

sub iterative
{
    my ($x0) = @_;
    my $x1;
	while (1)
	{
	    $x1 = g($x0);
	    printf("%12.10f\t%13.10f\n", $x1, $x1 - sqrt(2));

	    if (abs($x1 - $x0) < 0.0000000001)
	    {
	        last;
	    }
	    $x0 = $x1;
	}
	$x1;
}

sub g
{
    my ($x) = @_;
    ($x / 2) + (1 / $x);
}
