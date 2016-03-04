<?php
define("N", 3);

$a = [[-1,-2,7,-2],[1,-1,-2,6],[9,2,1,1],[2,8,-2,1]];
$b = [8,17,20,16];

# ピボット選択
pivoting($a,$b);
print "pivoting\n";
print "A\n";
disp_matrix($a);
print "B\n";
disp_vector($b);
print "\n";

# 前進消去
forward_elimination($a,$b);
print "forward elimination\n";
print "A\n";
disp_matrix($a);
print "B\n";
disp_vector($b);
print "\n";

# 後退代入
backward_substitution($a,$b);
print "X\n";
disp_vector($b);

# 前進消去
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
# 後退代入
function backward_substitution(&$a, &$b)
{
    foreach (range(0, N) as $pivot)
        $b[$pivot]  /= $a[$pivot][$pivot];
}
# ピボット選択
function pivoting(&$a, &$b)
{
    foreach (range(0, N) as $pivot)
    {
        # 各列で 一番値が大きい行を 探す
        $max_row =   $pivot;
        $max_val =   0;
        foreach (range($pivot, N) as $row)
        {
            if (abs($a[$row][$pivot]) > $max_val)
            {
                # 一番値が大きい行
                $max_val =   abs($a[$row][$pivot]);
                $max_row =   $row;
            }
        }

        # 一番値が大きい行と入れ替え
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
