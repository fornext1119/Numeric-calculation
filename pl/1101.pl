use constant N => 3;

# �x�L��@�ōő�ŗL�l�����߂�
main();

sub main
{
    my @a = ([5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]);
    my @x =  (1.0, 0.0, 0.0, 0.0);

    # �x�L��@ Power iteration
    $lambda = power(\@a, \@x);

    print "\neigenvalue\n";
    printf("%14.10f", $lambda);

    print "\neigenvector\n";
    disp_vector(\@x);
}

# �x�L��@ Power iteration
sub power
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

        # �s��̐� x1 = A �~ x0 
        my @x1;
        for $i (0..N)
        {
            for $j (0..N)
            {
                $x1[$i] += $$a[$i][$j] * $$x0[$j];
            }
        }

        # ���� inner product
        my $p0 = 0.0;
        my $p1 = 0.0;
        for $i (0..N)
        {
            $p0 += $x1[$i] *  $x1[$i];
            $p1 += $x1[$i] * $$x0[$i];
        }
        # �ŗL�l eigenvalue
        $lambda = $p0 / $p1;

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
