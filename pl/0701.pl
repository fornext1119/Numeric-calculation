# データ点の数 - 1
use constant N => 6;

my @x = ();
my @y = ();

# 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
for $i (0..N)
{
    my $d = $i * 1.5 - 4.5;
    $x[$i] = $d;
    $y[$i] = f($d);
}

# 0.5刻みで 与えられていない値を補間 
for $i (0..18)
{
    my $d  = $i * 0.5 - 4.5;
    my $d1 = f($d);
    my $d2 = lagrange($d, \@x, \@y);

    # 元の関数と比較
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", $d, $d1, $d2, $d1 - $d2);
}

# 元の関数
sub f
{
	my ($x) = @_;
    $x - ($x ** 3) / (3 * 2) + ($x ** 5) / (5 * 4 * 3 * 2);
}

# Lagrange (ラグランジュ) 補間
sub lagrange
{
	my ($d, $x, $y) = @_;
    my $sum = 0;
    for $i (0..N)
    {
        my $prod = $$y[$i];
        for $j (0..N)
        {
            if ($j != $i)
			{
                $prod *= ($d - $$x[$j]) / ($$x[$i] - $$x[$j]);
            }
        }
        $sum += $prod;
    }
    $sum;
}
