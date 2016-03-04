set-variable -name N -value 3 -option constant

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

# �x�L��@
function power($a, $x0)
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

        # �s��̐� x1 = A �~ x0 
        $x1 = (0.0, 0.0, 0.0, 0.0)
        foreach ($i in 0..$N)
        {
            foreach ($j in 0..$N)
            {
                $x1[$i] += $a[$i][$j] * $x0[$j]
            }
        }

        # ����
        $p0 = 0.0
        $p1 = 0.0
        foreach ($i in 0..$N)
        {
            $p0 += $x1[$i] * $x1[$i]
            $p1 += $x1[$i] * $x0[$i]
        }
        # �ŗL�l
        $lambda = $p0 / $p1

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
        foreach ($i in 0..$N)
        {
            $x0[$i] = $x1[$i]
        }
        $e0 = $e1
    }

    $lambda
}

# �x�L��@�ōő�ŗL�l�����߂�

$a = (5.0, 4.0, 1.0, 1.0),
     (4.0, 5.0, 1.0, 1.0),
     (1.0, 1.0, 4.0, 2.0),
     (1.0, 1.0, 2.0, 4.0)
$x = (1.0 ,0.0 ,0.0 ,0.0)

# �x�L��@
$lambda = (power $a $x)

Write-Host
Write-Host "eigenvalue"
Write-Host ([String]::Format("{0,14:F10}", $lambda))

Write-Host "eigenvector"
disp_vector $x
