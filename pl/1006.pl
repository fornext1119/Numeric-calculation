use constant N => 3;

my @a = ([5,2,3,4],[2,10,6,7],[3,6,15,9],[4,7,9,20]); 
my @b = (34,68,96,125);

print "A\n";
disp_matrix(\@a);
print "B\n";
disp_vector(\@b);
print "\n";

# 前進消去
forward_elimination(\@a,\@b);

print "LL^T\n";
disp_matrix(\@a);

# Ly=b から y を求める (前進代入)
my @y = (0,0,0,0);
forward_substitution(\@a,\@b,\@y);

print "Y\n";
disp_vector(\@y);

# L^Tx=y から x を求める (後退代入)
my @x = (0,0,0,0);
backward_substitution(\@a,\@y,\@x);

print "X\n";
disp_vector(\@x);

# 前進消去
sub forward_elimination
{
    my ($a, $b) = @_;

    for $pivot (0..N)
    {
        my $s = 0;
        for $col (0..($pivot-1))
        {
            $s += $$a[$pivot][$col] * $$a[$pivot][$col];
        }
        # ここで根号の中が負の値になると計算できない！
        $$a[$pivot][$pivot] = sqrt($$a[$pivot][$pivot] - $s);

        for $row (($pivot + 1)..N)
        {
            $s = 0;
            for $col (0..($pivot-1))
            {
                $s += $$a[$row][$col] * $$a[$pivot][$col];
            }
            $$a[$row][$pivot] = ($$a[$row][$pivot] - $s) / $$a[$pivot][$pivot];
            $$a[$pivot][$row] = $$a[$row][$pivot];
        } 
    }
}
# 前進代入
sub forward_substitution
{
    my ($a, $b, $y) = @_;

    for $row (0..N)
    {
        for $col (0..$row)
        {
            $$b[$row] -= $$a[$row][$col] * $$y[$col];
        }
        $$y[$row] = $$b[$row] / $$a[$row][$row];
    }
}
# 後退代入
sub backward_substitution
{
    my ($a, $y, $x) = @_;

    for ($row = N; $row >= 0; $row--)
    {
        for ($col = N; $col > $row; $col--)
        {
            $$y[$row] -= $$a[$row][$col] * $$x[$col];
        }
        $$x[$row] = $$y[$row] / $$a[$row][$row];
    }
}
# ２次元配列を表示
sub disp_matrix
{
	my ($matrix) = @_;
	foreach $row (@$matrix)
	{ 
		foreach $col (@$row)
		{
			printf("%14.10f\t", $col);
		}    
		print "\n";
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
