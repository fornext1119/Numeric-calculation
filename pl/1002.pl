use constant N => 3;

my @a = ([9,2,1,1],[2,8,-2,1],[-1,-2,7,-2],[1,-1,-2,6]);
my @b = (20,16,8,17);
my @c = (0,0,0,0);

# ガウス・ザイデル法
gauss(\@a, \@b, \@c);

print "X\n";
disp_vector(\@c);

# ガウス・ザイデル法
sub gauss
{
    my ($a, $b, $x0) = @_;

    while (1)
    {
        my $finish = 1;
        for $i (0..N)
        {
            my $x1 = 0;
            for $j (0..N)
            {
                if ($j != $i)
                {
                    $x1 += $$a[$i][$j] * $$x0[$j];
                }
            }
            $x1 = ($$b[$i] - $x1) / $$a[$i][$i];
            $finish = 0 if (abs($x1 - $$x0[$i]) > 0.0000000001);
            $$x0[$i] = $x1;
        }
        return if ($finish);

		disp_vector($x0);
    }
}
# １次元配列を表示
sub disp_vector
{
	my ($row) = @_;
	foreach $col (@$row)
	{
		printf("%14.10f\t", $col);
	}    
	print "\n";
}
