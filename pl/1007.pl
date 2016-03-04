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
print "LDL^T\n";
disp_matrix(\@a);

# Ly=b から y を求める (前進代入)
my @y = (0,0,0,0);
forward_substitution(\@a,\@b,\@y);
print "Y\n";
disp_vector(\@y);

# DL^Tx=y から x を求める (後退代入)
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
        # pivot < k の場合
        my $s = 0;
        for $col (0..($pivot-1))
        {
            $s = $$a[$pivot][$col];
            for $k (0..($col-1))
            {
                $s -= $$a[$pivot][$k] * $$a[$col][$k] * $$a[$k][$k];
            }
            $$a[$pivot][$col] = $s / $$a[$col][$col];
            $$a[$col][$pivot] = $$a[$pivot][$col];
        }
 
        # pivot == k の場合
        $s = $$a[$pivot][$pivot];
        for $k (0..($pivot-1))
        {
            $s -= $$a[$pivot][$k] * $$a[$pivot][$k] * $$a[$k][$k];
        }
        $$a[$pivot][$pivot] = $s;
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
        $$y[$row] = $$b[$row];
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
            $$y[$row] -= $$a[$row][$col] * $$a[$row][$row] * $$x[$col];
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
