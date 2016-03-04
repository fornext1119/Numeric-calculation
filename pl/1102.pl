use constant N => 3;

# �t�x�L��@�ōŏ��ŗL�l�����߂�
main();

sub main
{
	my @a = ([5.0, 4.0, 1.0, 1.0],
	         [4.0, 5.0, 1.0, 1.0],
	         [1.0, 1.0, 4.0, 2.0],
	         [1.0, 1.0, 2.0, 4.0]);
	my @x =  (1.0, 0.0, 0.0, 0.0);

	# LU����
	forward_elimination(\@a);

	# �t�x�L��@ Inverse iteration
	$lambda = inverse(\@a, \@x);

	print "\neigenvalue\n";
	printf("%14.10f", $lambda);

	print "\neigenvector\n";
	disp_vector(\@x);
}

# �t�x�L��@ Inverse iteration
sub inverse
{
    my ($a, $x0) = @_;
    my $lambda   = 0.0;

    # ���K�� (�x�N�g�� x0 �̒������P�ɂ���)
    normarize(\@$x0);
    my $e0 = 0.0;
    for $i (0..N)
    {
        $e0 += $$x0[$i];
    }

    for $k (1..200)
    {
        # �P�����z���\��
        printf("%3d\t", $k);
        disp_vector(\@$x0);

        # Ly = b ���� y �����߂� (�O�i���)
        my @b = (0.0, 0.0, 0.0, 0.0);
        my @y;
        for $i (0..N)
        {
            $b[$i] = $$x0[$i];
        }
        forward_substitution(\@$a, \@y, \@b);

        # Ux = y ���� x �����߂� (��ޑ��)
        my @x1;
        backward_substitution(\@$a, \@x1, \@y);

        # ���� inner product
        my $p0 = 0.0;
        my $p1 = 0.0;
        for $i (0..N)
        {
            $p0 += $x1[$i] *  $x1[$i];
            $p1 += $x1[$i] * $$x0[$i];
        }
        # �ŗL�l eigenvalue
        $lambda = $p1 / $p0;

	    # ���K�� (�x�N�g�� x1 �̒������P�ɂ���)
	    normarize(\@x1);
        # ��������
	    my $e1 = 0.0;
	    for $i (0..N)
	    {
	        $e1 += $x1[$i];
	    }
        last if (abs($e0 - $e1) < 0.00000000001);

        for $i (0..N)
        {
            $$x0[$i] = $x1[$i];
        }
        $e0 = $e1;
    }

    $lambda;
}

# LU����
sub forward_elimination
{
    my ($a) = @_;

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
        }
    }
}
# �O�i���
sub forward_substitution
{
    my ($a, $y, $b) = @_;

    for $row (0..N)
    {
        for $col (0..$row)
        {
            $$b[$row] -= $$a[$row][$col] * $$y[$col];
        }
        $$y[$row] = $$b[$row];
    }
}
# ��ޑ��
sub backward_substitution
{
    my ($a, $x, $y) = @_;

    for $row (reverse(0..N))
    {
	    for $col (reverse(($row + 1)..N))
        {
            $$y[$row] -= $$a[$row][$col] * $$x[$col];
        }
        $$x[$row] = $$y[$row] / $$a[$row][$row];
    }
}

# �P�����z���\��
sub disp_vector
{
    my ($x) = @_;
    for $i (0..N)
    {
        printf("%14.10f\t", $$x[$i]);
    }
    print "\n";
}
# ���K�� (�x�N�g���̒������P�ɂ���)
sub normarize
{
    my ($x) = @_;
    my  $s  = 0.0;
    for $i (0..N)
    {
        $s += $$x[$i] * $$x[$i];
    }
    $s = sqrt($s);
    
    for $i (0..N)
    {
        $$x[$i] /= $s;
    }
}
