set-variable -name N -value 3 -option constant

# LU分解
function forward_elimination($a)
{
    foreach ($pivot in 0..($N - 1))
    {
        foreach ($row in ($pivot + 1)..$N)
        {
            $s = $a[$row][$pivot] / $a[$pivot][$pivot]
            foreach ($col in $pivot..$N)
            {
                $a[$row][$col] -= $a[$pivot][$col]    * $s # これが 上三角行列
            }
            $a[$row][$pivot]    = $s                       # これが 下三角行列
        }
    }
}
# 前進代入
function forward_substitution($a, $y, $b)
{
    foreach ($row in 0..$N)
    {
        foreach ($col in 0..$row)
        {
            $b[$row] -= $a[$row][$col] * $y[$col]
        }
        $y[$row] = $b[$row]
    }
}
# 後退代入
function backward_substitution($a, $x, $y)
{
    foreach ($row in $N..0)
    {
        if ($row -lt $N)
        {
            foreach ($col in $N..($row + 1))
            {
                $y[$row] -= $a[$row][$col] * $x[$col]
            }
        }
        $x[$row] = $y[$row] / $a[$row][$row]
    }
}
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

# 逆ベキ乗法
function inverse($a, $x0)
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

        # Ly = b から y を求める (前進代入)
        $y = (0.0, 0.0, 0.0, 0.0)
        $b = (0.0, 0.0, 0.0, 0.0)
	    foreach ($i in 0..$N)
		{
            $b[$i] = $x0[$i]
        }
        forward_substitution $a $y $b

        # Ux = y から x を求める (後退代入)
        $x1 = (0.0, 0.0, 0.0, 0.0)
        backward_substitution $a $x1 $y

        # 内積
        $p0 = 0.0
        $p1 = 0.0
	    foreach ($i in 0..$N)
		{
            $p0 += $x1[$i] * $x1[$i]
            $p1 += $x1[$i] * $x0[$i]
        }
        # 固有値
        $lambda = $p1 / $p0

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
        $lambda0 = $lambda1
	    foreach ($i in 0..$N)
		{
            $x0[$i] = $x1[$i]
        }
		$e0 = $e1
    }

	$lambda
}

# 逆ベキ乗法で最小固有値を求める

$a = (5.0, 4.0, 1.0, 1.0),
     (4.0, 5.0, 1.0, 1.0),
     (1.0, 1.0, 4.0, 2.0),
     (1.0, 1.0, 2.0, 4.0)
$x = (1.0 ,0.0 ,0.0 ,0.0)

# LU分解
forward_elimination $a

# 逆ベキ乗法
$lambda = (inverse $a $x)

Write-Host
Write-Host "eigenvalue"
Write-Host ([String]::Format("{0,14:F10}", $lambda))

Write-Host "eigenvector"
disp_vector $x
