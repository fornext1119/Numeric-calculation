use constant N => 3;

my @a = ([-1,-2,7,-2],[1,-1,-2,6],[9,2,1,1],[2,8,-2,1]);
my @b = (8,17,20,16);

# �s�{�b�g�I��
pivoting(\@a,\@b);
print "pivoting\n";
print "A\n";
disp_matrix(\@a);
print "B\n";
disp_vector(\@b);
print "\n";

# �O�i����
forward_elimination(\@a,\@b);
print "forward elimination\n";
print "A\n";
disp_matrix(\@a);
print "B\n";
disp_vector(\@b);
print "\n";

# ��ޑ��
backward_substitution(\@a,\@b);
print "X\n";
disp_vector(\@b);

# �O�i����
sub forward_elimination
{
    my ($a, $b) = @_;

    for $pivot (0..N)
    {
        for $row (0..N)
        {
            next if ($row == $pivot);

            my $s = $$a[$row][$pivot] / $$a[$pivot][$pivot];
            for $col ($pivot..N)
            {
                $$a[$row][$col] -= $$a[$pivot][$col] * $s;
            }
            $$b[$row] -= $$b[$pivot] * $s;
        }
    }
}
# ��ޑ��
sub backward_substitution
{
    my ($a, $b) = @_;

    for $pivot (0..N)
    {
        $$b[$pivot]  /= $$a[$pivot][$pivot];
    }
}

# �s�{�b�g�I��
sub pivoting
{
    my ($a, $b) = @_;

    for $pivot (0..N)
    {
        # �e��� ��Ԓl���傫���s�� �T��
        my $max_row =   $pivot;
        my $max_val =   0;
        for $row ($pivot..N)
        {
            if (abs($$a[$row][$pivot]) > $max_val)
            {
                # ��Ԓl���傫���s
                $max_val =   abs($$a[$row][$pivot]);
                $max_row =   $row;
            }
        }

        # ��Ԓl���傫���s�Ɠ���ւ�
        if ($max_row != $pivot)
        {
            my $tmp;
            for $col (0..N)
            {
                $tmp                =   $$a[$max_row][$col];
                $$a[$max_row][$col] =   $$a[$pivot][$col];
                $$a[$pivot][$col]   =   $tmp;
            }
            $tmp          =   $$b[$max_row];
            $$b[$max_row] =   $$b[$pivot];
            $$b[$pivot]   =   $tmp;
        }
    }
}
# �Q�����z���\��
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
# �P�����z���\��
sub disp_vector
{
	my ($row) = @_;
	foreach $col (@$row)
	{
		printf("%14.10f\t", $col);
	}    
	print "\n";
}
