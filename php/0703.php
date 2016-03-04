<?php
# データ点の数 - 1
define("N", 6);

$x = array();
$y = array();

# 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
foreach (range(0, N) as $i)
{
    $d1 = $i * 1.5 - 4.5;
    $x[$i] = $d1;
    $y[$i] = f($d1);
}

# 差分商の表を作る
$d = array();
foreach (range(0, N) as $j)
{
    $d[0][$j] = $y[$j];
}
foreach (range(1, N) as $i)
{
	foreach (range(0, N - $i) as $j)
	{
        $d[$i][$j] = ($d[$i-1][$j+1] - $d[$i-1][$j]) / ($x[$j+$i] - $x[$j]);
    }
}
# ｎ階差分商
$a = array();
foreach (range(0, N) as $j)
{
    $a[$j] = $d[$j][0];
}

# 0.5刻みで 与えられていない値を補間 
foreach (range(0, 18) as $i)
{
    $d1 = $i * 0.5 - 4.5;
    $d2 = f($d1);
    $d3 = newton($d1, $x, $a);

    # 元の関数と比較
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", $d1, $d2, $d3, $d2 - $d3);
}

# 元の関数
function f($x)
{
    return $x - pow($x, 3) / (3 * 2) + pow($x, 5) / (5 * 4 * 3 * 2);
}

# Newton (ニュートン) 補間
function newton($d, $x, $a)
{
    $sum = $a[0];
	foreach (range(1, N) as $i)
    {
        $prod = $a[$i];
		foreach (range(0, $i - 1) as $j)
        {
            $prod *= ($d - $x[$j]);
        }
        $sum += $prod;
    }
    return $sum;
}
?>
