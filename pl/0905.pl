my $x = 2;
printf("%12.10f\n", bailey($x));

sub bailey
{
    my ($x0) = @_;
    my $x1;
	while (1)
	{
	    $x1 = $x0 - (f0($x0) / (f1($x0) - (f0($x0) * f2($x0) / (2 * f1($x0)))));
	    printf("%12.10f\t%13.10f\n", $x1, $x1 - sqrt(2));

	    if (abs($x1 - $x0) < 0.0000000001)
	    {
	        last;
	    }
	    $x0 = $x1;
	}
	$x1;
}

sub f0
{
    my ($x) = @_;
    $x * $x - 2;
}

sub f1
{
    my ($x) = @_;
    2 * $x;
}

sub f2
{
    my ($x) = @_;
    2;
}
