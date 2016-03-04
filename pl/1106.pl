use constant N => 3;

# ハウスホルダー変換とQR分解で固有値を求める
main();

sub main
{
	my @a = ([5.0, 4.0, 1.0, 1.0],
	         [4.0, 5.0, 1.0, 1.0],
	         [1.0, 1.0, 4.0, 2.0],
	         [1.0, 1.0, 2.0, 4.0]);
	my @d =  (0.0, 0.0, 0.0, 0.0);
	my @e =  (0.0, 0.0, 0.0, 0.0);

	# ハウスホルダー変換
	tridiagonalize(\@a, \@d, \@e);

	# QR分解
	decomp(\@a, \@d, \@e);

	print "\neigenvalue\n";
	disp_vector(\@d);

	print "\neigenvector\n";
	disp_matrix(\@a);
}

# ハウスホルダー変換
sub tridiagonalize
{
	my ($a, $d, $e) = @_;
	my @v = (0.0, 0.0, 0.0, 0.0);

    for $k (0..(N - 2))
	{
        my @w   = (0.0, 0.0, 0.0, 0.0);
        $$d[$k] = $$a[$k][$k];

        my $t = 0.0;
        for $i (($k + 1)..N)
		{
            $w[$i]  = $$a[$i][$k];
            $t     += ($w[$i] * $w[$i]);
        }
        my $s = sqrt($t); 
        $s = -$s if ($w[$k + 1] < 0);

        if (abs($s) < 0.00000000001)
		{
            $$e[$k + 1] = 0.0;
		}
        else
		{
            $$e[$k + 1] = -$s;
            $w[$k + 1] +=  $s;
            $s = 1 / sqrt($w[$k + 1] * $s);
            for $i (($k + 1)..N)
			{
                $w[$i] *= $s;
            }

            for $i (($k + 1)..N)
			{
                $s = 0.0;
                for $j (($k + 1)..N)
				{
                    if ($j <= $i)
					{
                        $s += $$a[$i][$j] * $w[$j];
					}
                    else
					{
                        $s += $$a[$j][$i] * $w[$j];
                    }
                }
                $v[$i] = $s;
            }

            $s = 0;
            for $i (($k + 1)..N)
			{
                $s += $w[$i] * $v[$i];
            }
            $s /= 2;
            for $i (($k + 1)..N)
			{
                $v[$i] -= $s * $w[$i];
            }
            for $i (($k + 1)..N)
			{
                for $j (($k + 1)..$i)
				{
                    $$a[$i][$j] -= $w[$i] * $v[$j] + $w[$j] * $v[$i];
                }
            }
            # 次の行は固有ベクトルを求めないなら不要
            for $i (($k + 1)..N)
			{
                $$a[$i][$k] = $w[$i];
            }
        } 
    }

    $$d[N - 1] = $$a[N - 1][N - 1];
    $$d[N]     = $$a[N][N];
    
    $$e[0]     = 0.0;  
    $$e[N]     = $$a[N][N - 1];
    
    # 次の行は固有ベクトルを求めないなら不要
    for $k (reverse(0..N))
	{
        $w     = (0.0, 0.0, 0.0, 0.0);
        if ($k < (N - 1))
		{
            for $i (($k + 1)..N)
			{
                $w[$i] = $$a[$i][$k];
            }
            for $i (($k + 1)..N)
			{
                $s = 0.0;
                for $j (($k + 1)..N)
				{
                    $s += $$a[$i][$j] * $w[$j];
                }
                $v[$i] = $s;
            }
            for $i (($k + 1)..N)
			{
                for $j (($k + 1)..N)
				{
                    $$a[$i][$j] -= $v[$i] * $w[$j];
                }
            }
        }
        for $i (0..N)
		{
            $$a[$i][$k] = 0.0;
        }
        $$a[$k][$k] = 1.0;
    }
}

# QR分解
sub decomp
{
	my ($a, $d, $e) = @_;

    $$e[0] = 1.0;
    my $h  = N;
    $h-- while (abs($$e[$h]) < 0.00000000001);

    while ($h > 0)
	{
        $$e[0] = 0.0;
        my $l = $h - 1;
        $l-- while (abs($$e[$l]) >= 0.00000000001);

        for $j (1..100)
		{
            my $w = ($$d[$h - 1] - $$d[$h]) / 2.0;
            my $s = sqrt($w * $w + $$e[$h] * $$e[$h]);
            $s = - $s if ($w < 0.0);

            my $x = $$d[$l] - $$d[$h] + $$e[$h] * $$e[$h] / ($w + $s);
            my $y = $$e[$l + 1];
            my $z = 0.0;
            my $t = 0.0;
            my $u = 0.0;
            for $k ($l..($h - 1))
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
                    $s = -$s if ($t < 0.0);
                    $u = $t * $s;
                }
                $w = $$d[$k] - $$d[$k + 1];
                $t = ($w * $s + 2 * $u * $$e[$k + 1]) * $s;
                $$d[$k    ] = $$d[$k    ] - $t;  
                $$d[$k + 1] = $$d[$k + 1] + $t;
                $$e[$k    ] = $u * $$e[$k] - $s * $z;
                $$e[$k + 1] = $$e[$k + 1] * ($u * $u - $s * $s) + $w * $s * $u;

                # 次の行は固有ベクトルを求めないなら不要
                for $i (0..N)
				{
                    $x = $$a[$k    ][$i];  
                    $y = $$a[$k + 1][$i];
                    $$a[$k    ][$i] = $u * $x - $s * $y;  
                    $$a[$k + 1][$i] = $s * $x + $u * $y;
                }

                if ($k < N - 1)
				{
                    $x = $$e[$k + 1];  
                    $y = -$s * $$e[$k + 2];  
                    $z = $y;
                    $$e[$k + 2] = $u * $$e[$k + 2];
                }
            }

	        printf("%3d\t", $j);
			disp_vector(\@$d);

	        # 収束判定
			last if (abs($$e[$h]) < 0.00000000001);
        }

        $$e[0] = 1.0;  
        $h-- while (abs($$e[$h]) < 0.00000000001);
    }

    # 次の行は固有ベクトルを求めないなら不要
    for $k (0..(N - 1))
	{
        $l = $k;
        for $i (($k + 1)..N) 
		{
            $l = $i if ($$d[$i] > $$d[$l]);
        }

        $t      = $$d[$k];  
        $$d[$k] = $$d[$l];  
        $$d[$l] = $t;

		for $i (0..N)
		{
	        $t          = $$a[$k][$i];  
	        $$a[$k][$i] = $$a[$l][$i];  
	        $$a[$l][$i] = $t;
        }
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
# ２次元配列を表示
sub disp_matrix
{
    my ($matrix) = @_;
    foreach $row (@$matrix)
    {
        foreach $col (@$row)
        {
            printf("%14.10f\t", $col);
        }
        print "\n";
    }
}

