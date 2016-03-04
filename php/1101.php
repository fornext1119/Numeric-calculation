<?php
define("N", 3);

# ベキ乗法で最大固有値を求める
main();

function main()
{
    $a = [[5.0, 4.0, 1.0, 1.0],
          [4.0, 5.0, 1.0, 1.0],
          [1.0, 1.0, 4.0, 2.0],
          [1.0, 1.0, 2.0, 4.0]];
    $x =  [1.0, 0.0, 0.0, 0.0];

    # ベキ乗法
    $lambda = power($a, $x);

    print "\neigenvalue\n";
    printf("%14.10f", $lambda);

    print "\neigenvector\n";
    disp_vector($x);
}

# ベキ乗法
function power(&$a, &$x0)
{
    $lambda   = 0.0;

    # 正規化 (ベクトル x0 の長さを１にする)
    normarize($x0);
    $e0 = 0.0;
    foreach (range(0, N) as $i)
    {
        $e0 += $x0[$i];
    }

    foreach (range(1, 200) as $k)
    {
        # １次元配列を表示
        printf("%3d\t", $k);
        disp_vector($x0);

        # 行列の積 x1 = A × x0 
        $x1 = [0.0, 0.0, 0.0, 0.0];
        foreach (range(0, N) as $i)
        {
            foreach (range(0, N) as $j)
            {
                $x1[$i] += $a[$i][$j] * $x0[$j];
            }
        }

        # 内積
        $p0 = 0.0;
        $p1 = 0.0;
        foreach (range(0, N) as $i)
        {
            $p0 += $x1[$i] * $x1[$i];
            $p1 += $x1[$i] * $x0[$i];
        }
        # 固有値
        $lambda = $p0 / $p1;

        # 正規化 (ベクトル x1 の長さを１にする)
        normarize($x1);
        # 収束判定
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

# １次元配列を表示
function disp_vector($row)
{
    foreach ($row as $col)
        printf("%14.10f\t", $col);
    print "\n";
}
# 正規化 (ベクトルの長さを１にする)
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
