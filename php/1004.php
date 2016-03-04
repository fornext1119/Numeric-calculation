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
print "forward elimination\n";
print "A\n";
disp_matrix($a);
print "B\n";
disp_vector($b);
print "\n";

# ��ޑ��
backward_substitution($a,$b);
print "X\n";
disp_vector($b);

# �O�i����
function forward_elimination(&$a, &$b)
{
    foreach (range(0, N) as $pivot)
    {
        foreach (range(0, N) as $row)
        {
            if ($row == $pivot) continue;

            $s = $a[$row][$pivot] / $a[$pivot][$pivot];
            foreach (range($pivot, N) as $col)
                $a[$row][$col] -= $a[$pivot][$col] * $s;
            $b[$row] -= $b[$pivot] * $s;
        }
    }
}
# ��ޑ��
function backward_substitution(&$a, &$b)
{
    foreach (range(0, N) as $pivot)
        $b[$pivot]  /= $a[$pivot][$pivot];
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
