use constant N => 3;

my @a = ([-1,-2,7,-2],[1,-1,-2,6],[9,2,1,1],[2,8,-2,1]); 
my @b = (8,17,20,16);

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
print "LU\n";
disp_matrix(\@a);

# Ly=b ���� y �����߂� (�O�i���)
my @y = (0,0,0,0);
forward_substitution(\@a,\@b,\@y);
print "Y\n";
disp_vector(\@y);

# Ux=y ���� x �����߂� (��ޑ��)
my @x = (0,0,0,0);
backward_substitution(\@a,\@y,\@x);
print "X\n";
disp_vector(\@x);

# �O�i����
sub forward_elimination
{
    my ($a, $b) = @_;

    for $pivot (0..(N - 1))
    {
        for $row (($pivot + 1)..N)
        {
            my $s = $$a[$row][$pivot] / $$a[$pivot][$pivot];
            for $col ($pivot..N)
            {
                $$a[$row][$col] -= $$a[$pivot][$col] * $s; # ���ꂪ ��O�p�s��
            }
            $$a[$row][$pivot]  = $s;                       # ���ꂪ ���O�p�s��
            # $$b[$row]       -= $$b[$pivot] * $s;         # ���̒l�͕ύX���Ȃ�
        }
    }
}
# Ly=b ���� y �����߂� (�O�i���)
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
# Ux=y ���� x �����߂� (��ޑ��)
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
