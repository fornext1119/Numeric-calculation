<?php
define("N", 3);

# QR�����ŌŗL�l�����߂�
main();

function main()
{
	$a = [[5.0, 4.0, 1.0, 1.0],
	      [4.0, 5.0, 1.0, 1.0],
	      [1.0, 1.0, 4.0, 2.0],
	      [1.0, 1.0, 2.0, 4.0]];
	$q = [[0.0, 0.0, 0.0, 0.0],
	      [0.0, 0.0, 0.0, 0.0],
	      [0.0, 0.0, 0.0, 0.0],
	      [0.0, 0.0, 0.0, 0.0]];
	$r = [[0.0, 0.0, 0.0, 0.0],
	      [0.0, 0.0, 0.0, 0.0],
	      [0.0, 0.0, 0.0, 0.0],
	      [0.0, 0.0, 0.0, 0.0]];

    foreach (range(1, 200) as $k)
	{
	    # QR����
	    decomp($a, $q, $r);
	    # �s��̐�
	    multiply($r, $q, $a);
	    # �Ίp�v�f��\��
	    printf("%3d\t", $k);
	    disp_eigenvalue($a);

	    # ��������
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

# QR����
function decomp($a, &$q, &$r)
{
	$x = [0.0, 0.0, 0.0, 0.0];

    foreach (range(0, N) as $k)
    {
	    foreach (range(0, N) as $i)
        {
            $x[$i] = $a[$i][$k];
		}
        if ($k > 0)
        {
		    foreach (range(0, ($k - 1)) as $j)
	        {
	            $t = 0.0;
			    foreach (range(0, N) as $i)
	            {
	                $t += $a[$i][$k] * $q[$i][$j];
	            }
	            $r[$j][$k] = $t;
	            $r[$k][$j] = 0.0;
			    foreach (range(0, N) as $i)
	            {
	                $x[$i] -= $t * $q[$i][$j];
	            }
	        }
		}
        $s = 0.0;
	    foreach (range(0, N) as $i)
        {
            $s += $x[$i] * $x[$i];
        }
        $r[$k][$k] = sqrt($s);
	    foreach (range(0, N) as $i)
        {
            $q[$i][$k] = $x[$i] / $r[$k][$k];
        }
    }
}

# �s��̐�
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

# �Ίp�v�f��\��
function disp_eigenvalue($a)
{
    foreach (range(0, N) as $i)
    {
	    printf("%14.10f\t", $a[$i][$i]);
    }
    print("\n");
}
?>
