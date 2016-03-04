<?php
define("N", 3);

$a = [[5,2,3,4],[2,10,6,7],[3,6,15,9],[4,7,9,20]];
$b = [34,68,96,125];

print "A\n";
disp_matrix($a);
print "B\n";
disp_vector($b);
print "\n";

# 前進消去
forward_elimination($a,$b);

print "LL^T\n";
disp_matrix($a);

# Ly=b から y を求める (前進代入)
$y = [0,0,0,0];
forward_substitution($a,$b,$y);

print "Y\n";
disp_vector($y);

# L^Tx=y から x を求める (後退代入)
$x = [0,0,0,0];
backward_substitution($a,$y,$x);

print "X\n";
disp_vector($x);

# 前進消去
function forward_elimination(&$a, $b)
{
    foreach (range(0, N) as $pivot)
    {
        $s = 0;
        for ($col = 0; $col < $pivot; $col++)
            $s += $a[$pivot][$col] * $a[$pivot][$col];
        # ここで根号の中が負の値になると計算できない！
        $a[$pivot][$pivot] = sqrt($a[$pivot][$pivot] - $s);

        for ($row = $pivot + 1; $row <= N; $row++)
        {
            $s = 0;
            for ($col = 0; $col < $pivot; $col++)
                $s += $a[$row][$col] * $a[$pivot][$col];
            $a[$row][$pivot] = ($a[$row][$pivot] - $s) / $a[$pivot][$pivot];
            $a[$pivot][$row] = $a[$row][$pivot];
        }
    }
}
# 前進代入
function forward_substitution($a, $b, &$y)
{
    foreach (range(0, N) as $row)
    {
        if ($row != 0)
	        foreach (range(0, $row - 1) as $col)
	            $b[$row] -= $a[$row][$col] * $y[$col];
        $y[$row] = $b[$row] / $a[$row][$row];
    }
}
# 後退代入
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
# ２次元配列を表示
function disp_matrix($matrix)
{
	foreach ($matrix as $row)
	{ 
		foreach ($row as $col)
			printf("%14.10f\t", $col);
		print "\n";
	}
}
# １次元配列を表示
function disp_vector($row)
{
	foreach ($row as $col)
		printf("%14.10f\t", $col);
	print "\n";
}
?>
