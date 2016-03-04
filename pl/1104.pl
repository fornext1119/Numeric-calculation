use constant N => 3;

# QR�����ŌŗL�l�����߂�
main();

sub main
{
	my @a = ([5.0, 4.0, 1.0, 1.0],
	         [4.0, 5.0, 1.0, 1.0],
	         [1.0, 1.0, 4.0, 2.0],
	         [1.0, 1.0, 2.0, 4.0]);
	my @q, @r;

	for $k (1..100)
	{
	    # QR����
	    decomp(\@a, \@q, \@r);
	    # �s��̐�
	    multiply(\@r, \@q, \@a);
	    # �Ίp�v�f��\��
	    printf("%3d\t", $k);
	    disp_eigenvalue(\@a);

	    # ��������
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

# QR����
sub decomp
{
    my ($a, $q, $r) = @_;
    
    my @x;

    for $k (0..N)
    {
        for $i (0..N)
        {
            $x[$i] = $$a[$i][$k];
		}
        for $j (0..($k - 1))
        {
            my $t = 0.0;
            for $i (0..N)
            {
                $t += $$a[$i][$k] * $$q[$i][$j];
            }
            $$r[$j][$k] = $t;
            $$r[$k][$j] = 0.0;
            for $i (0..N)
            {
                $x[$i] -= $t * $$q[$i][$j];
            }
        }

        my $s = 0.0;
        for $i (0..N)
        {
            $s += $x[$i] * $x[$i];
        }
        $$r[$k][$k] = sqrt($s);
        for $i (0..N)
        {
            $$q[$i][$k] = $x[$i] / $$r[$k][$k];
        }
    }
}

# �s��̐�
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

# �Ίp�v�f��\��
sub disp_eigenvalue
{
	my ($a) = @_;
	
    for $i (0..N)
    {
	    printf("%14.10f\t", $$a[$i][$i]);
    }
    print("\n");
}
