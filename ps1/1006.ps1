set-variable -name N -value 3 -option constant

# �O�i����
function forward_elimination($a, $b)
{
    foreach ($pivot in 0..$N)
    {
        $s = 0
        for ($col = 0; $col -lt $pivot; $col++)
        {
            $s += $a[$pivot][$col] * $a[$pivot][$col]
        }
        # �����ō����̒������̒l�ɂȂ�ƌv�Z�ł��Ȃ��I
        $a[$pivot][$pivot] = [Math]::Sqrt($a[$pivot][$pivot] - $s)

        for ($row = $pivot + 1; $row -le $N; $row++)
        {
            $s = 0
            for ($col = 0; $col -lt $pivot; $col++)
            {
                $s += $a[$row][$col] * $a[$pivot][$col]
            }
            $a[$row][$pivot] = ($a[$row][$pivot] - $s) / $a[$pivot][$pivot]
            $a[$pivot][$row] = $a[$row][$pivot]
        }
    }
}
# �O�i���
function forward_substitution($a, $b, $y)
{
    foreach ($row in 0..$N)
    {
        foreach ($col in 0..($row - 1))
        {
            $b[$row] -= $a[$row][$col] * $y[$col]
        }
        $y[$row] = $b[$row] / $a[$row][$row]
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

$a = (5.0, 2.0, 3.0, 4.0), (2.0, 10.0, 6.0, 7.0), (3.0, 6.0, 15.0, 9.0), (4.0, 7.0, 9.0, 20.0)
$b = 34.0, 68.0, 96.0, 125.0

Write-Host "A"
disp_matrix $a
Write-Host "B"
disp_vector $b
Write-Host ""

# �O�i����
forward_elimination $a $b

Write-Host "LL^T"
disp_matrix $a

# Ly=b ���� y �����߂� (�O�i���)
$y = 0.0, 0.0, 0.0, 0.0
forward_substitution $a $b $y

Write-Host "Y"
disp_vector $y

# L^Tx=y ���� x �����߂� (��ޑ��)
$x = 0.0, 0.0, 0.0, 0.0
backward_substitution $a $y $x

Write-Host "X"
disp_vector $x
