my $a = 1;
my $b = 2;
printf("%12.10f\n", bisection($a, $b));

sub bisection
{
    my ($a, $b) = @_;
    my $c;
	while (1)
	{
	    # 区間 (a, b) の中点 c = (a + b) / 2
	    $c = ($a + $b) / 2;
	    printf("%12.10f\t%13.10f\n", $c, $c - sqrt(2));

	    my $fc = f($c);
	    if (abs($fc) < 0.0000000001)
	    {
	        last;
	    }

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
	$c;
}

sub f
{
    my ($x) = @_;
    $x * $x - 2;
}
