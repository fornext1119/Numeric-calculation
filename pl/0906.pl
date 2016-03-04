my $x0 = 1;
my $x1 = 2;
printf("%12.10f\n", secant($x0, $x1));

sub secant
{
    my ($x0, $x1) = @_;
    my $x2;
	while (1)
	{
	    $x2 = $x1 - f($x1) * ($x1 - $x0) / (f($x1) - f($x0));
	    printf("%12.10f\t%13.10f\n", $x2, $x2 - sqrt(2));

	    if (abs($x2 - $x1) < 0.0000000001)
	    {
	        last;
	    }
	    $x0 = $x1;
	    $x1 = $x2;
	}
	$x2;
}

sub f
{
    my ($x) = @_;
    $x * $x - 2;
}
