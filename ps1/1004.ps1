set-variable -name N -value 3 -option constant

# 前進消去
function forward_elimination($a, $b)
{
    foreach ($pivot in 0..$N)
    {
        foreach ($row in 0..$N)
        {
            if ($row -eq $pivot)
            {
                continue
            }
            $s = $a[$row][$pivot] / $a[$pivot][$pivot]
            foreach ($col in $pivot..$N)
            {
                $a[$row][$col] -= $a[$pivot][$col]    * $s
            }
            $b[$row]           -= $b[$pivot]          * $s
        }
    }
}
# 後退代入
function backward_substitution($a, $b)
{
    foreach ($pivot in 0..$N)
    {
        $b[$pivot] /= $a[$pivot][$pivot]
    }
}
# ピボット選択
function pivoting($a, $b)
{
    foreach ($pivot in 0..$N)
    {
        # 各列で 一番値が大きい行を 探す
        $max_row =   $pivot
        $max_val =   0
        foreach ($row in $pivot..$N)
        {
            if ([Math]::Abs($a[$row][$pivot]) -gt $max_val)
            {
                # 一番値が大きい行
                $max_val =   [Math]::Abs($a[$row][$pivot])
                $max_row =   $row
            }
        }

        # 一番値が大きい行と入れ替え
        if ($max_row -ne $pivot)
        {
            foreach ($col in 0..$N)
            {
                $tmp               =   $a[$max_row][$col]
                $a[$max_row][$col] =   $a[$pivot][$col]
                $a[$pivot][$col]   =   $tmp
            }
            $tmp         =   $b[$max_row]
            $b[$max_row] =   $b[$pivot]
            $b[$pivot]   =   $tmp
        }
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

$a = (-1.0,-2.0,7.0,-2.0), (1.0,-1.0,-2.0,6.0), (9.0,2.0,1.0,1.0), (2.0,8.0,-2.0,1.0)
$b = 8.0, 17.0, 20.0, 16.0

# ピボット選択
pivoting $a $b

Write-Host "pivoting"
Write-Host "A"
disp_matrix $a
Write-Host "B"
disp_vector $b
Write-Host ""

# 前進消去
forward_elimination $a $b

Write-Host "forward elimination"
Write-Host "A"
disp_matrix $a
Write-Host "B"
disp_vector $b
Write-Host ""

# 後退代入
backward_substitution $a $b

Write-Host "X"
disp_vector $b
