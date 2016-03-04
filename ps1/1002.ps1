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
# ガウス・ザイデル法
function gauss($a, $b, $x0)
{
    while ($TRUE)
    {
        $finish = $TRUE
        foreach ($i in 0..$N)
        {
            $x1 = 0
            foreach ($j in 0..$N)
            {
                if ($j -ne $i)
                {
                    $x1 += $a[$i][$j] * $x0[$j]
                }
            }
            $x1 = ($b[$i] - $x1) / $a[$i][$i]
            if ([Math]::Abs($x1 - $x0[$i]) -gt 0.0000000001)
            {
                $finish = $FALSE
            }
            $x0[$i] = $x1
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

# ガウス・ザイデル法
gauss $a $b $c

Write-Host "X"
disp_vector  $c
