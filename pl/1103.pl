use constant N => 3;

# LR分解で固有値を求める
main();

sub main
{
	my @a = ([5.0, 4.0, 1.0, 1.0],
	         [4.0, 5.0, 1.0, 1.0],
	         [1.0, 1.0, 4.0, 2.0],
	         [1.0, 1.0, 2.0, 4.0]);
	my @l, @u;

	for $k (1..200)
	{
	    # LU分解
	    decomp(\@a, \@l, \@u);
	    # 行列の積
	    multiply(\@u, \@l, \@a);
	    # 対角要素を表示
	    printf("%3d\t", $k);
	    disp_eigenvalue(\@a);

	    # 収束判定
	    my $e = 0.0;
	    for $i (1..N)
	    {
	        for $j (0..($i - 1))
	        {
	            $e += abs($a[$i][$j]);
	        }
	    }
	    last if ($e < 0.00000000001);
	}

	print "\neigenvalue\n";
	disp_eigenvalue(\@a);
}

# LU分解
sub decomp
{
    my ($a, $l, $u) = @_;
    
    for $i (0..N)
    {
        for $j (1..N)
        {
            $$l[$i][$j] = 0.0;
            $$u[$i][$j] = 0.0;
        }
    }

    $$l[0][0] = 1.0;
    for $j (0..N)
    {
        $$u[0][$j] = $$a[0][$j];
    }

    for $i (1..N)
    {
        $$u[$i][0] = 0.0;
        $$l[0][$i] = 0.0;
        $$l[$i][0] = $$a[$i][0] / $$u[0][0];
    }
    for $i (1..N)
    {
        $$l[$i][$i] = 1.0;
        $t = $$a[$i][$i];
        for $k (0..$i)
        {
            $t -= $$l[$i][$k] * $$u[$k][$i];
        }
        $$u[$i][$i] = $t;
        if ($i < N)
        {
            for $j (($i + 1)..N)
            {
                $$u[$j][$i] = 0;
                $$l[$i][$j] = 0;
                $t = $$a[$j][$i];
                for $k (0..$i)
                {
                    $t -= $$l[$j][$k] * $$u[$k][$i];
                }
                $$l[$j][$i] = $t / $$u[$i][$i];
                $t = $$a[$i][$j];
                for $k (0..$i)
                {
                    $t -= $$l[$i][$k] * $$u[$k][$j];
                }
                $$u[$i][$j] = $t;
            }
        }
    }
}

# 行列の積
sub multiply
{
    my ($a, $b, $c) = @_;

    for $i (0..N)
    {
        for $j (0..N)
        {
            $s = 0.0;
            for $k (0..N)
            {
                $s += $$a[$i][$k] * $$b[$k][$j];
            }
            $$c[$i][$j] = $s;
        }
    }
}

# 対角要素を表示
sub disp_eigenvalue
{
	my ($a) = @_;
	
    for $i (0..N)
    {
	    printf("%14.10f\t", $$a[$i][$i]);
    }
    print("\n");
}
