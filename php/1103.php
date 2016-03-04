<?php
define("N", 3);

# LR•ª‰ð‚ÅŒÅ—L’l‚ð‹‚ß‚é
main();

function main()
{
	$a = [[5.0, 4.0, 1.0, 1.0],
	      [4.0, 5.0, 1.0, 1.0],
	      [1.0, 1.0, 4.0, 2.0],
	      [1.0, 1.0, 2.0, 4.0]];
	$l = [[0.0, 0.0, 0.0, 0.0],
	      [0.0, 0.0, 0.0, 0.0],
	      [0.0, 0.0, 0.0, 0.0],
	      [0.0, 0.0, 0.0, 0.0]];
	$u = [[0.0, 0.0, 0.0, 0.0],
	      [0.0, 0.0, 0.0, 0.0],
	      [0.0, 0.0, 0.0, 0.0],
	      [0.0, 0.0, 0.0, 0.0]];

    foreach (range(1, 200) as $k)
	{
	    # LU•ª‰ð
	    decomp($a, $l, $u);
	    # s—ñ‚ÌÏ
	    multiply($u, $l, $a);
	    # ‘ÎŠp—v‘f‚ð•\Ž¦
	    printf("%3d\t", $k);
	    disp_eigenvalue($a);

	    # Žû‘©”»’è
	    $e = 0.0;
	    foreach (range(1, N) as $i)
	    {
            foreach (range(0, ($i - 1)) as $j)
	        {
	            $e += abs($a[$i][$j]);
	        }
	    }
	    if ($e < 0.00000000001) break;
	}

	print "\neigenvalue\n";
	disp_eigenvalue($a);
}

# LU•ª‰ð
function decomp(&$a, &$l, &$u)
{
    foreach (range(0, N) as $i)
    {
        foreach (range(1, N) as $j)
        {
            $l[$i][$j] = 0.0;
            $u[$i][$j] = 0.0;
        }
    }

    $l[0][0] = 1.0;
    foreach (range(0, N) as $j)
    {
        $u[0][$j] = $a[0][$j];
    }

    foreach (range(1, N) as $i)
    {
        $u[$i][0] = 0.0;
        $l[0][$i] = 0.0;
        $l[$i][0] = $a[$i][0] / $u[0][0];
    }
    foreach (range(1, N) as $i)
    {
        $l[$i][$i] = 1.0;
        $t = $a[$i][$i];
        foreach (range(0, $i) as $k)
        {
            $t -= $l[$i][$k] * $u[$k][$i];
        }
        $u[$i][$i] = $t;
        if ($i < N)
        {
            foreach (range(($i + 1), N) as $j)
            {
                $u[$j][$i] = 0;
                $l[$i][$j] = 0;
                $t = $a[$j][$i];
                foreach (range(0, $i) as $k)
                {
                    $t -= $l[$j][$k] * $u[$k][$i];
                }
                $l[$j][$i] = $t / $u[$i][$i];
                $t = $a[$i][$j];
                foreach (range(0, $i) as $k)
                {
                    $t -= $l[$i][$k] * $u[$k][$j];
                }
                $u[$i][$j] = $t;
            }
        }
    }
}

# s—ñ‚ÌÏ
function multiply($a, $b, &$c)
{
    foreach (range(0, N) as $i)
    {
        foreach (range(0, N) as $j)
        {
            $s = 0.0;
            foreach (range(0, N) as $k)
            {
                $s += $a[$i][$k] * $b[$k][$j];
            }
            $c[$i][$j] = $s;
        }
    }
}

# ‘ÎŠp—v‘f‚ð•\Ž¦
function disp_eigenvalue($a)
{
    foreach (range(0, N) as $i)
    {
	    printf("%14.10f\t", $a[$i][$i]);
    }
    print("\n");
}
?>
