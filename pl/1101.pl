use constant N => 3;

# ベキ乗法で最大固有値を求める
main();

sub main
{
    my @a = ([5.0, 4.0, 1.0, 1.0],
             [4.0, 5.0, 1.0, 1.0],
             [1.0, 1.0, 4.0, 2.0],
             [1.0, 1.0, 2.0, 4.0]);
    my @x =  (1.0, 0.0, 0.0, 0.0);

    # ベキ乗法 Power iteration
    $lambda = power(\@a, \@x);

    print "\neigenvalue\n";
    printf("%14.10f", $lambda);

    print "\neigenvector\n";
    disp_vector(\@x);
}

# ベキ乗法 Power iteration
sub power
{
    my ($a, $x0) = @_;
    my $lambda   = 0.0;

    # 正規化 (ベクトル x0 の長さを１にする)
    normarize(\@$x0);
    my $e0 = 0.0;
    for $i (0..N)
    {
        $e0 += $$x0[$i];
    }

    for $k (1..200)
    {
        # １次元配列を表示
        printf("%3d\t", $k);
        disp_vector(\@$x0);

        # 行列の積 x1 = A × x0 
        my @x1;
        for $i (0..N)
        {
            for $j (0..N)
            {
                $x1[$i] += $$a[$i][$j] * $$x0[$j];
            }
        }

        # 内積 inner product
        my $p0 = 0.0;
        my $p1 = 0.0;
        for $i (0..N)
        {
            $p0 += $x1[$i] *  $x1[$i];
            $p1 += $x1[$i] * $$x0[$i];
        }
        # 固有値 eigenvalue
        $lambda = $p0 / $p1;

        # 正規化 (ベクトル x1 の長さを１にする)
        normarize(\@x1);
        # 収束判定
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

# １次元配列を表示
sub disp_vector
{
    my ($x) = @_;
    for $i (0..N)
    {
        printf("%14.10f\t", $$x[$i]);
    }
    print "\n";
}
# 正規化 (ベクトルの長さを１にする)
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
