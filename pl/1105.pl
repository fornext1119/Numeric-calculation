use Math::Trig;
use constant N => 3;

# ヤコビ法で固有値を求める
main();

sub main
{
	my @a = ([5.0, 4.0, 1.0, 1.0],
	         [4.0, 5.0, 1.0, 1.0],
	         [1.0, 1.0, 4.0, 2.0],
	         [1.0, 1.0, 2.0, 4.0]);
	my @v = ([1.0 ,0.0 ,0.0 ,0.0],
	         [0.0 ,1.0 ,0.0 ,0.0],
	         [0.0 ,0.0 ,1.0 ,0.0],
	         [0.0 ,0.0 ,0.0 ,1.0]);

	# ヤコビ法
	jacobi(\@a, \@v);

	print "\neigenvalue\n";
	disp_eigenvalue(\@a);

	print "\neigenvector\n";
	disp_eigenvector(\@v);
}

# ヤコビ法
sub jacobi
{
    my ($a, $v) = @_;

    for $k (1..100)
    {
        # 最大値を探す
        $max_val = 0.0;
	    for $i (0..(N - 1))
	    {
		    for $j (($i + 1)..N)
		    {
                if ($max_val < abs($$a[$i][$j]))
				{
                    $max_val = abs($$a[$i][$j]);
                    $p = $i;
                    $q = $j;
                }
            }
        }

        # θ を求める
        if (abs($$a[$p][$p] - $$a[$q][$q]) < 0.00000000001)
		{
            # a_{pp} ＝ a_{qq} のとき、回転角ｔをπ/4にする
            $t = pi / 4.0;
            $t = -$t if ($$a[$p][$p] < 0.0)
		}
        else
		{
            # a_{pp} ≠ a_{qq} のとき
            $t = atan(2.0 * $$a[$p][$q] / ($$a[$p][$p] - $$a[$q][$q])) / 2.0;
        }

        # θ を使って 行列 U を作成し、A = U^t × A × U
        $c = cos($t);
        $s = sin($t);
        # U^t × A
	    for $i (0..N)
	    {
            $t1 =  $$a[$p][$i] * $c + $$a[$q][$i] * $s;
            $t2 = -$$a[$p][$i] * $s + $$a[$q][$i] * $c;
            $$a[$p][$i] = $t1;
            $$a[$q][$i] = $t2;
            # 固有ベクトル
            $t1 =  $$v[$p][$i] * $c + $$v[$q][$i] * $s;
            $t2 = -$$v[$p][$i] * $s + $$v[$q][$i] * $c;
            $$v[$p][$i] = $t1;
            $$v[$q][$i] = $t2;
        }
        # A × U
	    for $i (0..N)
	    {
            $t1 =  $$a[$i][$p] * $c + $$a[$i][$q] * $s;
            $t2 = -$$a[$i][$p] * $s + $$a[$i][$q] * $c;
            $$a[$i][$p] = $t1;
            $$a[$i][$q] = $t2;
        }

        # 行列の対角要素を表示 (固有値)
        printf("%3d\t", $k);
		disp_eigenvalue(\@$a);

        # 収束判定
        last if ($max_val < 0.00000000001);
    }
}

# 対角要素を表示
sub disp_eigenvalue
{
    my ($a) = @_;
    for $i (0..N)
    {
        printf("%14.10f\t", $$a[$i][$i]);
    }
    print "\n";
}
# 固有ベクトルを表示
sub disp_eigenvector
{
    my ($matrix) = @_;

    for $row (@$matrix)
    {
        normarize(\@$row);
        disp_vector(\@$row);
    }
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
