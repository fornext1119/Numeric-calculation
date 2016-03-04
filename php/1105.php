<?php
define("N", 3);

# ヤコビ法で固有値を求める
main();

function main()
{
	$a = [[5.0, 4.0, 1.0, 1.0],
	      [4.0, 5.0, 1.0, 1.0],
	      [1.0, 1.0, 4.0, 2.0],
	      [1.0, 1.0, 2.0, 4.0]];
	$v = [[1.0 ,0.0 ,0.0 ,0.0],
	      [0.0 ,1.0 ,0.0 ,0.0],
	      [0.0 ,0.0 ,1.0 ,0.0],
	      [0.0 ,0.0 ,0.0 ,1.0]];

	# ヤコビ法
	jacobi($a, $v);

	print "\neigenvalue\n";
	disp_eigenvalue($a);

	print "\neigenvector\n";
	disp_eigenvector($v);
}

# ヤコビ法
function jacobi(&$a, &$v)
{
    foreach (range(1, 100) as $k)
    {
        # 最大値を探す
        $max_val = 0.0;
	    foreach (range(0, (N - 1)) as $i)
	    {
		    foreach (range(($i + 1), N) as $j)
		    {
                if ($max_val < abs($a[$i][$j]))
				{
                    $max_val = abs($a[$i][$j]);
                    $p = $i;
                    $q = $j;
                }
			}
        }

        # θ を求める
        if (abs($a[$p][$p] - $a[$q][$q]) < 0.00000000001)
		{
            # a_{pp} ＝ a_{qq} のとき、回転角ｔをπ/4にする
            $t = M_PI / 4.0;
			if ($a[$p][$p] < 0.0)
	            $t = -$t;
		}
        else
		{
            # a_{pp} ≠ a_{qq} のとき
            $t = atan(2.0 * $a[$p][$q] / ($a[$p][$p] - $a[$q][$q])) / 2.0;
        }

        # θ を使って 行列 U を作成し、A = U^t × A × U
        $c = cos($t);
        $s = sin($t);
        # U^t × A
	    foreach (range(0, N) as $i)
	    {
            $t1 =  $a[$p][$i] * $c + $a[$q][$i] * $s;
            $t2 = -$a[$p][$i] * $s + $a[$q][$i] * $c;
            $a[$p][$i] = $t1;
            $a[$q][$i] = $t2;
            # 固有ベクトル
            $t1 =  $v[$p][$i] * $c + $v[$q][$i] * $s;
            $t2 = -$v[$p][$i] * $s + $v[$q][$i] * $c;
            $v[$p][$i] = $t1;
            $v[$q][$i] = $t2;
        }
        # A × U
	    foreach (range(0, N) as $i)
	    {
            $t1 =  $a[$i][$p] * $c + $a[$i][$q] * $s;
            $t2 = -$a[$i][$p] * $s + $a[$i][$q] * $c;
            $a[$i][$p] = $t1;
            $a[$i][$q] = $t2;
        }

        # 行列の対角要素を表示 (固有値)
        printf("%3d\t", $k);
		disp_eigenvalue($a);

        # 収束判定
        if ($max_val < 0.00000000001) break;
    }
}

# 対角要素を表示
function disp_eigenvalue($a)
{
    foreach (range(0, N) as $i)
        printf("%14.10f\t", $a[$i][$i]);
    print "\n";
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
# 固有ベクトルを表示
function disp_eigenvector($matrix)
{
    foreach ($matrix as $row)
    {
        normarize($row);
        disp_vector($row);
    }
}
?>
