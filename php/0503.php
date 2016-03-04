<?php
# 自作の正接関数
function myTan($x, $x2, $n, $t)
{
    $t = $x2 / ($n - $t);
    $n -= 2;  
    if ($n <= 1)
        return $x / (1 - $t);
    else
        return myTan($x, $x2, $n, $t);
}
foreach (range(0, 12) as $i)
{
    if (($i * 15) % 180 != 0)
    {
        $degree = $i * 15 - 90;
        $radian = deg2rad($degree);
        $x2     = $radian * $radian;
        # 自作の正接関数
        $d1     = myTan($radian, $x2, 15, 0.0); # 15:必要な精度が得られる十分大きな奇数
        # 標準の正接関数
        $d2     = tan($radian);
        # 標準関数との差異
        printf("%3d : %13.10f - %13.10f = %13.10f\n", $degree, $d1, $d2, $d1 - $d2);
    }
}
?>
