set-variable -name N -value 3 -option constant

# １次元配列を表示
function disp_vector($row)
{
    foreach ($col in $row)
    {
        Write-Host ([String]::Format("{0,14:F10}", $col)) -noNewLine
    }
    Write-Host 
}
# ヤコビの反復法
function jacobi($a, $b, $x0)
{
    while ($TRUE)
    {
        $x1 = 0.0, 0.0, 0.0, 0.0
        $finish = $TRUE
        foreach ($i in 0..$N)
        {
            $x1[$i] = 0
            foreach ($j in 0..$N)
            {
                if ($j -ne $i)
                {
                    $x1[$i] += $a[$i][$j] * $x0[$j]
                }
            }
            $x1[$i] = ($b[$i] - $x1[$i]) / $a[$i][$i]
            if ([Math]::Abs($x1[$i] - $x0[$i]) -gt 0.0000000001)
            {
                $finish = $FALSE
            }
        }
        foreach ($i in 0..$N)
        {
            $x0[$i] = $x1[$i]
        }
        if ($finish)
        {
            return
        }
        disp_vector  $x0
    }
}

$a = (9.0,2.0,1.0,1.0), (2.0,8.0,-2.0,1.0), (-1.0,-2.0,7.0,-2.0), (1.0,-1.0,-2.0,6.0)
$b = 20.0, 16.0, 8.0, 17.0
$c =  0.0,  0.0, 0.0,  0.0

# ヤコビの反復法
jacobi $a $b $c

Write-Host "X"
disp_vector  $c
