<?php
define("N", 3);

$a = [[9,2,1,1],[2,8,-2,1],[-1,-2,7,-2],[1,-1,-2,6]];
$b = [20,16,8,17];
$c = [0,0,0,0];

# ヤコビの反復法
jacobi($a, $b, $c);

print "X\n";
disp_vector($c);

# ヤコビの反復法
function jacobi($a, $b, &$x0)
{
    while (true)
    {
        $x1 = array();
        $finish = true;
        foreach (range(0, N) as $i)
        {
            $x1[$i] = 0;
            foreach (range(0, N) as $j)
            {
                if ($j != $i)
                    $x1[$i] += $a[$i][$j] * $x0[$j];
            }
            $x1[$i] = ($b[$i] - $x1[$i]) / $a[$i][$i];
            if (abs($x1[$i] - $x0[$i]) > 0.0000000001) $finish = false;
        }

        foreach (range(0, N) as $i)
        {
            $x0[$i] = $x1[$i];
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
