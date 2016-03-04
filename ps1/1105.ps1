set-variable -name N -value 3 -option constant

# 対角要素を表示
function disp_eigenvalue($a)
{
    foreach ($i in 0..$N)
    {
        Write-Host ([String]::Format("{0,14:F10}`t", $a[$i][$i])) -nonewline
    }
    Write-Host
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

# 固有ベクトルを表示
function disp_eigenvector($matrix)
{
    foreach ($row in $matrix)
    {
        normarize $row
        disp_vector $row
    }
}

# ヤコビ法
function jacobi($a, $v)
{
    foreach ($k in 1..100)
    {
        # 最大値を探す
        $max_val = 0.0
	    foreach ($i in 0..($N - 1))
	    {
		    foreach ($j in ($i + 1)..$N)
		    {
                if ($max_val -lt [Math]::Abs($a[$i][$j]))
				{
                    $max_val = [Math]::Abs($a[$i][$j])
                    $p = $i
                    $q = $j
                }
			}
        }

        # θ を求める
        if ([Math]::Abs($a[$p][$p] - $a[$q][$q]) -lt 0.00000000001)
		{
            # a_{pp} ＝ a_{qq} のとき、回転角ｔをπ/4にする
            $t = [Math]::PI / 4.0
			if ($a[$p][$p] -lt 0.0)
			{
	            $t = -$t
			}
		}
        else
		{
            # a_{pp} ≠ a_{qq} のとき
            $t = [Math]::Atan(2.0 * $a[$p][$q] / ($a[$p][$p] - $a[$q][$q])) / 2.0
        }

        # θ を使って 行列 U を作成し、A = U^t × A × U
        $c = [Math]::Cos($t)
        $s = [Math]::Sin($t)
        # U^t × A
	    foreach ($i in 0..$N)
	    {
            $t1 =  $a[$p][$i] * $c + $a[$q][$i] * $s
            $t2 = -$a[$p][$i] * $s + $a[$q][$i] * $c
            $a[$p][$i] = $t1
            $a[$q][$i] = $t2
            # 固有ベクトル
            $t1 =  $v[$p][$i] * $c + $v[$q][$i] * $s
            $t2 = -$v[$p][$i] * $s + $v[$q][$i] * $c
            $v[$p][$i] = $t1
            $v[$q][$i] = $t2
        }
        # A × U
	    foreach ($i in 0..$N)
	    {
            $t1 =  $a[$i][$p] * $c + $a[$i][$q] * $s
            $t2 = -$a[$i][$p] * $s + $a[$i][$q] * $c
            $a[$i][$p] = $t1
            $a[$i][$q] = $t2
        }

        # 行列の対角要素を表示 (固有値)
     	Write-Host ([string]::format("{0,3:D}`t", $k)) -nonewline
		disp_eigenvalue $a

        # 収束判定
        if ($max_val -lt 0.00000000001)
		{
			break
		}
    }
}

# ヤコビ法で固有値を求める

$a = (5.0, 4.0, 1.0, 1.0),
     (4.0, 5.0, 1.0, 1.0),
     (1.0, 1.0, 4.0, 2.0),
     (1.0, 1.0, 2.0, 4.0)
$v = (1.0 ,0.0 ,0.0 ,0.0),
     (0.0 ,1.0 ,0.0 ,0.0),
     (0.0 ,0.0 ,1.0 ,0.0),
     (0.0 ,0.0 ,0.0 ,1.0)

# ヤコビ法
jacobi $a $v

Write-Host
Write-Host "固有値"
disp_eigenvalue $a

Write-Host
Write-Host "固有ベクトル"
disp_eigenvector $v
