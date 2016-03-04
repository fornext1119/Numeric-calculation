<?php
define("N", 3);

# ���R�r�@�ŌŗL�l�����߂�
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

	# ���R�r�@
	jacobi($a, $v);

	print "\neigenvalue\n";
	disp_eigenvalue($a);

	print "\neigenvector\n";
	disp_eigenvector($v);
}

# ���R�r�@
function jacobi(&$a, &$v)
{
    foreach (range(1, 100) as $k)
    {
        # �ő�l��T��
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

        # �� �����߂�
        if (abs($a[$p][$p] - $a[$q][$q]) < 0.00000000001)
		{
            # a_{pp} �� a_{qq} �̂Ƃ��A��]�p������/4�ɂ���
            $t = M_PI / 4.0;
			if ($a[$p][$p] < 0.0)
	            $t = -$t;
		}
        else
		{
            # a_{pp} �� a_{qq} �̂Ƃ�
            $t = atan(2.0 * $a[$p][$q] / ($a[$p][$p] - $a[$q][$q])) / 2.0;
        }

        # �� ���g���� �s�� U ���쐬���AA = U^t �~ A �~ U
        $c = cos($t);
        $s = sin($t);
        # U^t �~ A
	    foreach (range(0, N) as $i)
	    {
            $t1 =  $a[$p][$i] * $c + $a[$q][$i] * $s;
            $t2 = -$a[$p][$i] * $s + $a[$q][$i] * $c;
            $a[$p][$i] = $t1;
            $a[$q][$i] = $t2;
            # �ŗL�x�N�g��
            $t1 =  $v[$p][$i] * $c + $v[$q][$i] * $s;
            $t2 = -$v[$p][$i] * $s + $v[$q][$i] * $c;
            $v[$p][$i] = $t1;
            $v[$q][$i] = $t2;
        }
        # A �~ U
	    foreach (range(0, N) as $i)
	    {
            $t1 =  $a[$i][$p] * $c + $a[$i][$q] * $s;
            $t2 = -$a[$i][$p] * $s + $a[$i][$q] * $c;
            $a[$i][$p] = $t1;
            $a[$i][$q] = $t2;
        }

        # �s��̑Ίp�v�f��\�� (�ŗL�l)
        printf("%3d\t", $k);
		disp_eigenvalue($a);

        # ��������
        if ($max_val < 0.00000000001) break;
    }
}

# �Ίp�v�f��\��
function disp_eigenvalue($a)
{
    foreach (range(0, N) as $i)
        printf("%14.10f\t", $a[$i][$i]);
    print "\n";
}
# �P�����z���\��
function disp_vector($row)
{
    foreach ($row as $col)
        printf("%14.10f\t", $col);
    print "\n";
}
# ���K�� (�x�N�g���̒������P�ɂ���)
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
# �ŗL�x�N�g����\��
function disp_eigenvector($matrix)
{
    foreach ($matrix as $row)
    {
        normarize($row);
        disp_vector($row);
    }
}
?>
