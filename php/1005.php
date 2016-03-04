<?php
define("N", 3);

$a = [[-1,-2,7,-2],[1,-1,-2,6],[9,2,1,1],[2,8,-2,1]];
$b = [8,17,20,16];

# �s�{�b�g�I��
pivoting($a,$b);
print "pivoting\n";
print "A\n";
disp_matrix($a);
print "B\n";
disp_vector($b);
print "\n";

# �O�i����
forward_elimination($a,$b);
print "LU\n";
disp_matrix($a);

# Ly=b ���� y �����߂� (�O�i���)
$y = [0,0,0,0];
forward_substitution($a,$b,$y);
print "Y\n";
disp_vector($y);

# Ux=y ���� x �����߂� (��ޑ��)
$x = [0,0,0,0];
backward_substitution($a,$y,$x);
print "X\n";
disp_vector($x);

# �O�i����
function forward_elimination(&$a, $b)
{
    foreach (range(0, N - 1) as $pivot)
    {
        foreach (range($pivot + 1, N) as $row)
        {
            $s = $a[$row][$pivot] / $a[$pivot][$pivot];
            foreach (range($pivot, N) as $col)
                $a[$row][$col] -= $a[$pivot][$col]    * $s; # ���ꂪ ��O�p�s��
            $a[$row][$pivot]    = $s;                       # ���ꂪ ���O�p�s��
            # $b[$row]         -= $b[$pivot]          * $s; # ���̒l�͕ύX���Ȃ�
        }
    }
}
# Ly=b ���� y �����߂� (�O�i���)
function forward_substitution($a, $b, &$y)
{
    foreach (range(0, N) as $row)
    {
        foreach (range(0, $row) as $col)
            $b[$row] -= $a[$row][$col] * $y[$col];
        $y[$row] = $b[$row];
    }
}
# Ux=y ���� x �����߂� (��ޑ��)
function backward_substitution($a, $y, &$x)
{
    foreach (range(N, 0) as $row)
    {
        if (($row + 1) <= N)
            foreach (range(N, $row + 1) as $col)
                $y[$row] -= $a[$row][$col] * $x[$col];
        $x[$row] = $y[$row] / $a[$row][$row];
    }
}
# �s�{�b�g�I��
function pivoting(&$a, &$b)
{
    foreach (range(0, N) as $pivot)
    {
        # �e��� ��Ԓl���傫���s�� �T��
        $max_row =   $pivot;
        $max_val =   0;
        foreach (range($pivot, N) as $row)
        {
            if (abs($a[$row][$pivot]) > $max_val)
            {
                # ��Ԓl���傫���s
                $max_val =   abs($a[$row][$pivot]);
                $max_row =   $row;
            }
        }

        # ��Ԓl���傫���s�Ɠ���ւ�
        if ($max_row != $pivot)
        {
            foreach (range(0, N) as $col)
            {
                $tmp               =   $a[$max_row][$col];
                $a[$max_row][$col] =   $a[$pivot][$col];
                $a[$pivot][$col]   =   $tmp;
            }
            $tmp         =   $b[$max_row];
            $b[$max_row] =   $b[$pivot];
            $b[$pivot]   =   $tmp;
        }
    }
}
# �Q�����z���\��
function disp_matrix($matrix)
{
	foreach ($matrix as $row)
	{ 
		foreach ($row as $col)
			printf("%14.10f\t", $col);
		print "\n";
	}
}
# �P�����z���\��
function disp_vector($row)
{
	foreach ($row as $col)
		printf("%14.10f\t", $col);
	print "\n";
}
?>
