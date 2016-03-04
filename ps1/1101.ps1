set-variable -name N -value 3 -option constant

# １次元配列を表示
function disp_vector($row)
{
    foreach ($col in $row)
    {
        Write-Host ([String]::Format("{0,14:F10}", $col)) -nonewline
    }
    Write-Host
}
# 正規化 (ベクトルの長さを１にする)
function normarize($x)
{
    $s = 0.0

    foreach ($i in 0..$N)
    {
        $s += $x[$i] * $x[$i]
    }
    $s = [Math]::Sqrt($s)
    
    foreach ($i in 0..$N)
    {
        $x[$i] /= $s
    }
}

# ベキ乗法
function power($a, $x0)
{
    $lambda = 0.0

    # 正規化 (ベクトル x0 の長さを１にする)
    normarize $x0
    $e0 = 0.0
    foreach ($i in 0..$N)
    {
        $e0 += $x0[$i]
    }

    foreach ($k in 1..200)
    {
        # １次元配列を表示
        Write-Host ([string]::format("{0,3:D}`t", $k)) -nonewline
        disp_vector $x0

        # 行列の積 x1 = A × x0 
        $x1 = (0.0, 0.0, 0.0, 0.0)
        foreach ($i in 0..$N)
        {
            foreach ($j in 0..$N)
            {
                $x1[$i] += $a[$i][$j] * $x0[$j]
            }
        }

        # 内積
        $p0 = 0.0
        $p1 = 0.0
        foreach ($i in 0..$N)
        {
            $p0 += $x1[$i] * $x1[$i]
            $p1 += $x1[$i] * $x0[$i]
        }
        # 固有値
        $lambda = $p0 / $p1

        # 正規化 (ベクトル x1 の長さを１にする)
        normarize $x1
        # 収束判定
        $e1 = 0.0
        foreach ($i in 0..$N)
        {
            $e1 += $x1[$i]
        }
        if ([Math]::Abs($e0 - $e1) -lt 0.00000000001)
        {
            break
        }
        foreach ($i in 0..$N)
        {
            $x0[$i] = $x1[$i]
        }
        $e0 = $e1
    }

    $lambda
}

# ベキ乗法で最大固有値を求める

$a = (5.0, 4.0, 1.0, 1.0),
     (4.0, 5.0, 1.0, 1.0),
     (1.0, 1.0, 4.0, 2.0),
     (1.0, 1.0, 2.0, 4.0)
$x = (1.0 ,0.0 ,0.0 ,0.0)

# ベキ乗法
$lambda = (power $a $x)

Write-Host
Write-Host "eigenvalue"
Write-Host ([String]::Format("{0,14:F10}", $lambda))

Write-Host "eigenvector"
disp_vector $x
