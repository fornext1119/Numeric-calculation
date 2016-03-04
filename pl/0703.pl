# データ点の数 - 1
use constant N => 6;

my @x = ();
my @y = ();

# 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
for $i (0..N)
{
    my $d1 = $i * 1.5 - 4.5;
    $x[$i] = $d1;
    $y[$i] = f($d1);
}

# 差分商の表を作る
my @d = ();
for $j (0..N)
{
    $d[0][$j] = $y[$j];
}
for $i (1..N)
{
	for $j (0..(N - $i))
	{
        $d[$i][$j] = ($d[$i-1][$j+1] - $d[$i-1][$j]) / ($x[$j+$i] - $x[$j]);
    }
}
# ｎ階差分商
my @a = ();
for $j (0..N)
{
    $a[$j] = $d[$j][0];
}

# 0.5刻みで 与えられていない値を補間 
for $i (0..18)
{
    my $d1 = $i * 0.5 - 4.5;
    my $d2 = f($d1);
    my $d3 = newton($d1, \@x, \@a);

    # 元の関数と比較
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", $d1, $d2, $d3, $d2 - $d3);
}

# 元の関数
sub f
{
	my ($x) = @_;
    $x - ($x ** 3) / (3 * 2) + ($x ** 5) / (5 * 4 * 3 * 2);
}

# Newton (ニュートン) 補間
sub newton
{
	my ($d, $x, $a) = @_;
    my $sum = $$a[0];
    for $i (1..N)
    {
        my $prod = $$a[$i];
        for $j (0..($i - 1))
        {
            $prod *= ($d - $$x[$j]);
        }
        $sum += $prod;
    }
    $sum;
}
