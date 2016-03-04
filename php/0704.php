<?php
# データ点の数 - 1
define("N",    6);
define("Nx2", 13);

$x  = array();
$y  = array();
$yd = array();

# 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
foreach (range(0, N) as $i)
{
    $d1     = $i * 1.5 - 4.5;
    $x[$i]  = $d1;
    $y[$i]  = f($d1);
    $yd[$i] = fd($d1);
}

# 差分商の表を作る
$z = array();
$d = array();
foreach (range(0, Nx2) as $i)
{
	$j        = (int)($i / 2);
    $z[$i]    = $x[$j];
    $d[0][$i] = $y[$j];
}
foreach (range(1, Nx2) as $i)
{
	foreach (range(0, Nx2 - $i) as $j)
	{
        if ($i == 1 && $j % 2 == 0)
            $d[$i][$j] = $yd[(int)($j / 2)];
        else
	        $d[$i][$j] = ($d[$i-1][$j+1] - $d[$i-1][$j]) / ($z[$j+$i] - $z[$j]);
    }
}
# ｎ階差分商
$a = array();
foreach (range(0, Nx2) as $j)
{
    $a[$j] = $d[$j][0];
}

# 0.5刻みで 与えられていない値を補間 
foreach (range(0, 18) as $i)
{
    $d1 = $i * 0.5 - 4.5;
    $d2 = f($d1);
    $d3 = hermite($d1, $z, $a);

    # 元の関数と比較
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", $d1, $d2, $d3, $d2 - $d3);
}

# 元の関数
function f($x)
{
    return $x - pow($x, 3) / (3 * 2) + pow($x, 5) / (5 * 4 * 3 * 2);
}
# 導関数
function fd($x)
{
    return 1 - pow($x, 2) / 2 + pow($x, 4) / (4 * 3 * 2);
}

# Hermite (エルミート) 補間
function hermite($d, $z, $a)
{
    $sum = $a[0];
	foreach (range(1, Nx2) as $i)
    {
        $prod = $a[$i];
		foreach (range(0, $i - 1) as $j)
        {
            $prod *= ($d - $z[$j]);
        }
        $sum += $prod;
    }
    return $sum;
}
?>
