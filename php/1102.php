<?php
define("N", 3);

# �t�x�L��@�ōŏ��ŗL�l�����߂�
main();

function main()
{
	$a = [[5.0, 4.0, 1.0, 1.0],
	      [4.0, 5.0, 1.0, 1.0],
	      [1.0, 1.0, 4.0, 2.0],
	      [1.0, 1.0, 2.0, 4.0]];
	$x =  [1.0, 0.0, 0.0, 0.0];

	# LU����
	forward_elimination($a);

	# �t�x�L��@
	$lambda = inverse($a, $x);

	print "\neigenvalue\n";
	printf("%14.10f", $lambda);

	print "\neigenvector\n";
	disp_vector($x);
}

# �t�x�L��@
function inverse(&$a, &$x0)
{
    $lambda   = 0.0;

    # ���K�� (�x�N�g�� x0 �̒������P�ɂ���)
    normarize($x0);
    $e0 = 0.0;
    foreach (range(0, N) as $i)
    {
        $e0 += $x0[$i];
    }

    foreach (range(1, 200) as $k)
    {
        # �P�����z���\��
        printf("%3d\t", $k);
        disp_vector($x0);

		# Ly=b ���� y �����߂� (�O�i���)
		$y = [0.0, 0.0, 0.0, 0.0];
		forward_substitution($a, $y, $x0);

		# Ux=y ���� x �����߂� (��ޑ��)
		$x1 = [0.0, 0.0, 0.0, 0.0];
		backward_substitution($a, $x1, $y);

        # ����
        $p0 = 0.0;
        $p1 = 0.0;
	    foreach (range(0, N) as $i)
        {
            $p0 += $x1[$i] * $x1[$i];
            $p1 += $x1[$i] * $x0[$i];
        }
        # �ŗL�l
        $lambda = $p1 / $p0;

	    # ���K�� (�x�N�g�� x1 �̒������P�ɂ���)
	    normarize($x1);
        # ��������
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

# LU����
function forward_elimination(&$a)
{
    foreach (range(0, N - 1) as $pivot)
    {
        foreach (range($pivot + 1, N) as $row)
        {
            $s = $a[$row][$pivot] / $a[$pivot][$pivot];
            foreach (range($pivot, N) as $col)
                $a[$row][$col] -= $a[$pivot][$col]    * $s; # ���ꂪ ��O�p�s��
            $a[$row][$pivot]    = $s;                       # ���ꂪ ���O�p�s��
        }
    }
}
# �O�i���
function forward_substitution($a, &$y, $b)
{
    foreach (range(0, N) as $row)
    {
        foreach (range(0, $row) as $col)
            $b[$row] -= $a[$row][$col] * $y[$col];
        $y[$row] = $b[$row];
    }
}
# ��ޑ��
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
?>
