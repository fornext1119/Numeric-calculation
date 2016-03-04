set-variable -name N -value 3 -option constant

# �O�i����
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
# ��ޑ��
function backward_substitution($a, $b)
{
    foreach ($pivot in 0..$N)
    {
        $b[$pivot] /= $a[$pivot][$pivot]
    }
}
# �s�{�b�g�I��
function pivoting($a, $b)
{
    foreach ($pivot in 0..$N)
    {
        # �e��� ��Ԓl���傫���s�� �T��
        $max_row =   $pivot
        $max_val =   0
        foreach ($row in $pivot..$N)
        {
            if ([Math]::Abs($a[$row][$pivot]) -gt $max_val)
            {
                # ��Ԓl���傫���s
                $max_val =   [Math]::Abs($a[$row][$pivot])
                $max_row =   $row
            }
        }

        # ��Ԓl���傫���s�Ɠ���ւ�
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
# �P�����z���\��
function disp_vector($row)
{
    foreach ($col in $row)
    {
        Write-Host ([String]::Format("{0,14:F10}", $col)) -noNewLine
    }
    Write-Host 
}
# �Q�����z���\��
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

# �s�{�b�g�I��
pivoting $a $b

Write-Host "pivoting"
Write-Host "A"
disp_matrix $a
Write-Host "B"
disp_vector $b
Write-Host ""

# �O�i����
forward_elimination $a $b

Write-Host "forward elimination"
Write-Host "A"
disp_matrix $a
Write-Host "B"
disp_vector $b
Write-Host ""

# ��ޑ��
backward_substitution $a $b

Write-Host "X"
disp_vector $b
