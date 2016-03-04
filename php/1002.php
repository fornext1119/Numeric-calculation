<?php
define("N", 3);

$a = [[9,2,1,1],[2,8,-2,1],[-1,-2,7,-2],[1,-1,-2,6]];
$b = [20,16,8,17];
$c = [0,0,0,0];

# ガウス・ザイデル法
gauss($a, $b, $c);

print "X\n";
disp_vector($c);

# ガウス・ザイデル法
function gauss($a, $b, &$x0)
{
    while (true)
    {
        $finish = true;
        foreach (range(0, N) as $i)
        {
            $x1 = 0;
            foreach (range(0, N) as $j)
            {
                if ($j != $i)
                    $x1 += $a[$i][$j] * $x0[$j];
            }
            $x1 = ($b[$i] - $x1) / $a[$i][$i];
            if (abs($x1 - $x0[$i]) > 0.0000000001) $finish = false;
            $x0[$i] = $x1;
        }
        if ($finish) return;

		disp_vector($x0);
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
