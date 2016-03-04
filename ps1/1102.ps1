set-variable -name N -value 3 -option constant

# LU����
function forward_elimination($a)
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
        }
    }
}
# �O�i���
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
# ��ޑ��
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
# �P�����z���\��
function disp_vector($row)
{
    foreach ($col in $row)
    {
        Write-Host ([String]::Format("{0,14:F10}", $col)) -nonewline
    }
    Write-Host
}
# ���K�� (�x�N�g���̒������P�ɂ���)
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

# �t�x�L��@
function inverse($a, $x0)
{
    $lambda = 0.0

    # ���K�� (�x�N�g�� x0 �̒������P�ɂ���)
    normarize $x0
	$e0 = 0.0
    foreach ($i in 0..$N)
	{
        $e0 += $x0[$i]
    }

    foreach ($k in 1..200)
	{
        # �P�����z���\��
    	Write-Host ([string]::format("{0,3:D}`t", $k)) -nonewline
        disp_vector $x0

        # Ly = b ���� y �����߂� (�O�i���)
        $y = (0.0, 0.0, 0.0, 0.0)
        $b = (0.0, 0.0, 0.0, 0.0)
	    foreach ($i in 0..$N)
		{
            $b[$i] = $x0[$i]
        }
        forward_substitution $a $y $b

        # Ux = y ���� x �����߂� (��ޑ��)
        $x1 = (0.0, 0.0, 0.0, 0.0)
        backward_substitution $a $x1 $y

        # ����
        $p0 = 0.0
        $p1 = 0.0
	    foreach ($i in 0..$N)
		{
            $p0 += $x1[$i] * $x1[$i]
            $p1 += $x1[$i] * $x0[$i]
        }
        # �ŗL�l
        $lambda = $p1 / $p0

	    # ���K�� (�x�N�g�� x1 �̒������P�ɂ���)
	    normarize $x1
        # ��������
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

# �t�x�L��@�ōŏ��ŗL�l�����߂�

$a = (5.0, 4.0, 1.0, 1.0),
     (4.0, 5.0, 1.0, 1.0),
     (1.0, 1.0, 4.0, 2.0),
     (1.0, 1.0, 2.0, 4.0)
$x = (1.0 ,0.0 ,0.0 ,0.0)

# LU����
forward_elimination $a

# �t�x�L��@
$lambda = (inverse $a $x)

Write-Host
Write-Host "eigenvalue"
Write-Host ([String]::Format("{0,14:F10}", $lambda))

Write-Host "eigenvector"
disp_vector $x
