<?php
define("N", 3);

# ハウスホルダー変換とQR分解で固有値を求める
main();

function main()
{
	$a = [[5.0, 4.0, 1.0, 1.0],
	      [4.0, 5.0, 1.0, 1.0],
	      [1.0, 1.0, 4.0, 2.0],
	      [1.0, 1.0, 2.0, 4.0]];
	$d =  [0.0, 0.0, 0.0, 0.0];
	$e =  [0.0, 0.0, 0.0, 0.0];

	# ハウスホルダー変換
	tridiagonalize($a, $d, $e);

	# QR分解
	decomp($a, $d, $e);

	print "\neigenvalue\n";
	disp_vector($d);

	print "\neigenvector\n";
	disp_matrix($a);
}

# ハウスホルダー変換
function tridiagonalize(&$a, &$d, &$e)
{
	$v =  [0.0, 0.0, 0.0, 0.0];

    foreach (range(0, (N - 2)) as $k)
	{
        $w   = [0.0, 0.0, 0.0, 0.0];
        $d[$k] = $a[$k][$k];

        $t = 0.0;
	    foreach (range(($k + 1), N) as $i)
		{
            $w[$i]  = $a[$i][$k];
            $t     += ($w[$i] * $w[$i]);
        }
        $s = sqrt($t); 
        if ($w[$k + 1] < 0)
			$s = -$s;

        if (abs($s) < 0.00000000001)
		{
            $e[$k + 1] = 0.0;
		}
        else
		{
            $e[$k + 1] = -$s;
            $w[$k + 1] +=  $s;
            $s = 1 / sqrt($w[$k + 1] * $s);
		    foreach (range(($k + 1), N) as $i)
			{
                $w[$i] *= $s;
            }

		    foreach (range(($k + 1), N) as $i)
			{
                $s = 0.0;
			    foreach (range(($k + 1), N) as $j)
				{
                    if ($j <= $i)
					{
                        $s += $a[$i][$j] * $w[$j];
					}
                    else
					{
                        $s += $a[$j][$i] * $w[$j];
                    }
                }
                $v[$i] = $s;
            }

            $s = 0;
		    foreach (range(($k + 1), N) as $i)
			{
                $s += $w[$i] * $v[$i];
            }
            $s /= 2;
		    foreach (range(($k + 1), N) as $i)
			{
                $v[$i] -= $s * $w[$i];
            }
		    foreach (range(($k + 1), N) as $i)
			{
			    foreach (range(($k + 1), $i) as $j)
				{
                    $a[$i][$j] -= $w[$i] * $v[$j] + $w[$j] * $v[$i];
                }
            }
            # 次の行は固有ベクトルを求めないなら不要
		    foreach (range(($k + 1), N) as $i)
			{
                $a[$i][$k] = $w[$i];
            }
        } 
    }

    $d[N - 1] = $a[N - 1][N - 1];
    $d[N]     = $a[N][N];
    
    $e[0]     = 0.0;  
    $e[N]     = $a[N][N - 1];
    
    # 次の行は固有ベクトルを求めないなら不要
    foreach (range(N, 0) as $k)
	{
        $w = [0.0, 0.0, 0.0, 0.0];
        if ($k < (N - 1))
		{
		    foreach (range(($k + 1), N) as $i)
			{
                $w[$i] = $a[$i][$k];
            }
		    foreach (range(($k + 1), N) as $i)
			{
                $s = 0.0;
			    foreach (range(($k + 1), N) as $j)
				{
                    $s += $a[$i][$j] * $w[$j];
                }
                $v[$i] = $s;
            }
		    foreach (range(($k + 1), N) as $i)
			{
			    foreach (range(($k + 1), N) as $j)
				{
                    $a[$i][$j] -= $v[$i] * $w[$j];
                }
            }
        }
	    foreach (range(0, N) as $i)
		{
            $a[$i][$k] = 0.0;
        }
        $a[$k][$k] = 1.0;
    }
}

# QR分解
function decomp(&$a, &$d, &$e)
{
    $e[0] = 1.0;
    $h  = N;
    while (abs($e[$h]) < 0.00000000001) $h--;

    while ($h > 0)
	{
        $e[0] = 0.0;
        $l = $h - 1;
        while (abs($e[$l]) >= 0.00000000001) $l--;

	    foreach (range(1, 100) as $j)
		{
            $w = ($d[$h - 1] - $d[$h]) / 2.0;
            $s = sqrt($w * $w + $e[$h] * $e[$h]);
            if ($w < 0.0)
				$s = - $s;

            $x = $d[$l] - $d[$h] + $e[$h] * $e[$h] / ($w + $s);
            $y = $e[$l + 1];
            $z = 0.0;
            $t = 0.0;
            $u = 0.0;
		    foreach (range(l, ($h - 1)) as $k)
			{
                if (abs($x) >= abs($y))
				{
                    $t = -$y / $x;  
                    $u = 1 / sqrt($t * $t + 1.0);
                    $s = $t * $u;
				}
                else
				{
                    $t = -$x / $y;
                    $s = 1 / sqrt($t * $t + 1.0);  
                    if ($t < 0.0)
						$s = -$s;
                    $u = $t * $s;
                }
                $w = $d[$k] - $d[$k + 1];
                $t = ($w * $s + 2 * $u * $e[$k + 1]) * $s;
                $d[$k    ] = $d[$k    ] - $t;  
                $d[$k + 1] = $d[$k + 1] + $t;
                $e[$k    ] = $u * $e[$k] - $s * $z;
                $e[$k + 1] = $e[$k + 1] * ($u * $u - $s * $s) + $w * $s * $u;

                # 次の行は固有ベクトルを求めないなら不要
			    foreach (range(0, N) as $i)
				{
                    $x = $a[$k    ][$i];  
                    $y = $a[$k + 1][$i];
                    $a[$k    ][$i] = $u * $x - $s * $y;  
                    $a[$k + 1][$i] = $s * $x + $u * $y;
                }

                if ($k < N - 1)
				{
                    $x = $e[$k + 1];  
                    $y = -$s * $e[$k + 2];  
                    $z = $y;
                    $e[$k + 2] = $u * $e[$k + 2];
                }
            }

	        printf("%3d\t", $j);
			disp_vector($d);

	        # 収束判定
			if (abs($e[$h]) < 0.00000000001) break;
        }

        $e[0] = 1.0;  
        while (abs($e[$h]) < 0.00000000001) $h--;
    }

    # 次の行は固有ベクトルを求めないなら不要
    foreach (range(0, (N - 1)) as $k)
	{
        $l = $k;
	    foreach (range(($k + 1), N) as $i)
		{
            if ($d[$i] > $d[$l])
				$l = $i;
        }

        $t      = $d[$k];  
        $d[$k] = $d[$l];  
        $d[$l] = $t;

	    foreach (range(0, N) as $i)
		{
	        $t          = $a[$k][$i];  
	        $a[$k][$i] = $a[$l][$i];  
	        $a[$l][$i] = $t;
        }
    }
}

# １次元配列を表示
function disp_vector($row)
{
    foreach ($row as $col)
    {
        printf("%14.10f\t", $col);
    }
    print "\n";
}
# ２次元配列を表示
function disp_matrix($matrix)
{
    foreach ($matrix as $row)
    {
        foreach ($row as $col)
        {
            printf("%14.10f\t", $col);
        }
        print "\n";
    }
}
?>
