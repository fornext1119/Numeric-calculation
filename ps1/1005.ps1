set-variable -name N -value 3 -option constant

# �O�i����
function forward_elimination($a, $b)
{
    foreach ($pivot in 0..($N - 1))
    {
        foreach ($row in ($pivot + 1)..$N)
        {
            $s = $a[$row][$pivot] / $a[$pivot][$pivot]
            foreach ($col in $pivot..$N)
            {
                $a[$row][$col] -= $a[$pivot][$col]    * $s # ���ꂪ ��O�p�s��
            }
            $a[$row][$pivot]    = $s                       # ���ꂪ ���O�p�s��
            # $b[$row]         -= $b[$pivot]          * $s # ���̒l�͕ύX���Ȃ�
        }
    }
}
# �O�i���
function forward_substitution($a, $b, $y)
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
# ��ޑ��
function backward_substitution($a, $y, $x)
{
    foreach ($row in $N..0)
    {
        if (($row+1) -le $N)
        {
            foreach ($col in $N..($row + 1))
            {
                $y[$row] -= $a[$row][$col] * $x[$col]
            }
        }
        $x[$row] = $y[$row] / $a[$row][$row]
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

Write-Host "LU"
disp_matrix $a

# Ly=b ���� y �����߂� (�O�i���)
$y = 0.0, 0.0, 0.0, 0.0
forward_substitution $a $b $y

Write-Host "Y"
disp_vector $y

# Ux=y ���� x �����߂� (��ޑ��)
$x = 0.0, 0.0, 0.0, 0.0
backward_substitution $a $y $x

Write-Host "X"
disp_vector $x
