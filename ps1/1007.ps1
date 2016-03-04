set-variable -name N -value 3 -option constant

# 前進消去
function forward_elimination($a, $b)
{
    foreach ($pivot in 0..$N)
    {
        # pivot < k の場合
        $s = 0
        for ($col = 0; $col -lt $pivot; $col++)
        {
            $s = $a[$pivot][$col]
            for ($k = 0; $k -lt $col; $k++)
            {
                $s -= $a[$pivot][$k] * $a[$col][$k] * $a[$k][$k]
            }
            $a[$pivot][$col] = $s / $a[$col][$col]
            $a[$col][$pivot] = $a[$pivot][$col]
        }

        # pivot == k の場合
        $s = $a[$pivot][$pivot]
        for ($k = 0; $k -lt $pivot; $k++)
        {
            foreach ($k in 0..($pivot-1))
            {
                $s -= $a[$pivot][$k] * $a[$pivot][$k] * $a[$k][$k]
            }
        }
        $a[$pivot][$pivot] = $s
    }
}
# 前進代入
function forward_substitution($a, $b, $y)
{
    foreach ($row in 0..$N)
    {
        foreach ($col in 0..($row - 1))
        {
            $b[$row] -= $a[$row][$col] * $y[$col]
        }
        $y[$row] = $b[$row]
    }
}
# 後退代入
function backward_substitution($a, $y, $x)
{
    foreach ($row in $N..0)
    {
        if (($row+1) -le $N)
        {
            foreach ($col in $N..($row + 1))
            {
                $y[$row] -= $a[$row][$col] * $a[$row][$row] * $x[$col]
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
        Write-Host ([String]::Format("{0,14:F10}", $col)) -noNewLine
    }
    Write-Host 
}
# ２次元配列を表示
function disp_matrix($matrix)
{
	foreach ($row in $matrix)
	{ 
        foreach ($col in $row)
        {
            Write-Host ([String]::Format("{0,14:F10}", $col)) -noNewLine
        }
        Write-Host 
	}
}

$a = (5.0, 2.0, 3.0, 4.0), (2.0, 10.0, 6.0, 7.0), (3.0, 6.0, 15.0, 9.0), (4.0, 7.0, 9.0, 20.0)
$b = 34.0, 68.0, 96.0, 125.0

Write-Host "A"
disp_matrix $a
Write-Host "B"
disp_vector $b
Write-Host ""

# 前進消去
forward_elimination $a $b

Write-Host "LDL^T"
disp_matrix $a

# Ly=b から y を求める (前進代入)
$y = 0.0, 0.0, 0.0, 0.0
forward_substitution $a $b $y

Write-Host "Y"
disp_vector $y

# DL^Tx=y から x を求める (後退代入)
$x = 0.0, 0.0, 0.0, 0.0
backward_substitution $a $y $x

Write-Host "X"
disp_vector $x
