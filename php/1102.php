<?php
define("N", 3);

# 逆ベキ乗法で最小固有値を求める
main();

function main()
{
	$a = [[5.0, 4.0, 1.0, 1.0],
	      [4.0, 5.0, 1.0, 1.0],
	      [1.0, 1.0, 4.0, 2.0],
	      [1.0, 1.0, 2.0, 4.0]];
	$x =  [1.0, 0.0, 0.0, 0.0];

	# LU分解
	forward_elimination($a);

	# 逆ベキ乗法
	$lambda = inverse($a, $x);

	print "\neigenvalue\n";
	printf("%14.10f", $lambda);

	print "\neigenvector\n";
	disp_vector($x);
}

# 逆ベキ乗法
function inverse(&$a, &$x0)
{
    $lambda   = 0.0;

    # 正規化 (ベクトル x0 の長さを１にする)
    normarize($x0);
    $e0 = 0.0;
    foreach (range(0, N) as $i)
    {
        $e0 += $x0[$i];
    }

    foreach (range(1, 200) as $k)
    {
        # １次元配列を表示
        printf("%3d\t", $k);
        disp_vector($x0);

		# Ly=b から y を求める (前進代入)
		$y = [0.0, 0.0, 0.0, 0.0];
		forward_substitution($a, $y, $x0);

		# Ux=y から x を求める (後退代入)
		$x1 = [0.0, 0.0, 0.0, 0.0];
		backward_substitution($a, $x1, $y);

        # 内積
        $p0 = 0.0;
        $p1 = 0.0;
	    foreach (range(0, N) as $i)
        {
            $p0 += $x1[$i] * $x1[$i];
            $p1 += $x1[$i] * $x0[$i];
        }
        # 固有値
        $lambda = $p1 / $p0;

	    # 正規化 (ベクトル x1 の長さを１にする)
	    normarize($x1);
        # 収束判定
	    $e1 = 0.0;
	    foreach (range(0, N) as $i)
	    {
	        $e1 += $x1[$i];
	    }
        if (abs($e0 - $e1) < 0.00000000001) break;

	    foreach (range(0, N) as $i)
        {
            $x0[$i] = $x1[$i];
        }
        $e0 = $e1;
    }

    return $lambda;
}

# LU分解
function forward_elimination(&$a)
{
    foreach (range(0, N - 1) as $pivot)
    {
        foreach (range($pivot + 1, N) as $row)
        {
            $s = $a[$row][$pivot] / $a[$pivot][$pivot];
            foreach (range($pivot, N) as $col)
                $a[$row][$col] -= $a[$pivot][$col]    * $s; # これが 上三角行列
            $a[$row][$pivot]    = $s;                       # これが 下三角行列
        }
    }
}
# 前進代入
function forward_substitution($a, &$y, $b)
{
    foreach (range(0, N) as $row)
    {
        foreach (range(0, $row) as $col)
            $b[$row] -= $a[$row][$col] * $y[$col];
        $y[$row] = $b[$row];
    }
}
# 後退代入
function backward_substitution($a, &$x, $y)
{
    foreach (range(N, 0) as $row)
    {
        if (($row + 1) <= N)
            foreach (range(N, $row + 1) as $col)
                $y[$row] -= $a[$row][$col] * $x[$col];
        $x[$row] = $y[$row] / $a[$row][$row];
    }
}
# １次元配列を表示
function disp_vector($row)
{
    foreach ($row as $col)
        printf("%14.10f\t", $col);
    print "\n";
}
# 正規化 (ベクトルの長さを１にする)
function normarize(&$x)
{
    $s = 0.0;
    foreach (range(0, N) as $i)
    {
        $s += $x[$i] * $x[$i];
    }
    $s = sqrt($s);
    
    foreach (range(0, N) as $i)
    {
        $x[$i] /= $s;
    }
}
?>
