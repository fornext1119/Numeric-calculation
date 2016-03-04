set-variable -name N -value 3 -option constant

# �Ίp�v�f��\��
function disp_eigenvalue($a)
{
    foreach ($i in 0..$N)
    {
        Write-Host ([String]::Format("{0,14:F10}`t", $a[$i][$i])) -nonewline
    }
    Write-Host
}

# LU����
function decomp($a, $l, $u)
{
    foreach ($i in 0..$N)
    {
        foreach ($j in 1..$N)
        {
            $l[$i][$j] = 0.0
            $u[$i][$j] = 0.0
        }
    }

    $l[0][0] = 1.0
    foreach ($j in 0..$N)
    {
        $u[0][$j] = $a[0][$j]
    }

    foreach ($i in 1..$N)
    {
        $u[$i][0] = 0.0
        $l[0][$i] = 0.0
        $l[$i][0] = $a[$i][0] / $u[0][0]
    }
    foreach ($i in 1..$N)
    {
        $l[$i][$i] = 1.0
        $t = $a[$i][$i]
        foreach ($k in 0..$i)
        {
            $t -= $l[$i][$k] * $u[$k][$i]
        }
        $u[$i][$i] = $t
        if ($i -lt $N)
        {
            foreach ($j in ($i + 1)..$N)
            {
                $u[$j][$i] = 0
                $l[$i][$j] = 0
                $t = $a[$j][$i]
                foreach ($k in 0..$i)
                {
                    $t -= $l[$j][$k] * $u[$k][$i]
                }
                $l[$j][$i] = $t / $u[$i][$i]
                $t = $a[$i][$j]
                foreach ($k in 0..$i)
                {
                    $t -= $l[$i][$k] * $u[$k][$j]
                }
                $u[$i][$j] = $t
            }
        }
    }
}

# �s��̐�
function multiply($a, $b, $c)
{
    foreach ($i in 0..$N)
    {
        foreach ($j in 0..$N)
        {
            $s = 0.0
            foreach ($k in 0..$N)
            {
                $s += $a[$i][$k] * $b[$k][$j]
            }
            $c[$i][$j] = $s
        }
    }
}

# LR�����ŌŗL�l�����߂�

$a = (5.0, 4.0, 1.0, 1.0),
     (4.0, 5.0, 1.0, 1.0),
     (1.0, 1.0, 4.0, 2.0),
     (1.0, 1.0, 2.0, 4.0)
$l = (0.0, 0.0, 0.0, 0.0),
     (0.0, 0.0, 0.0, 0.0),
     (0.0, 0.0, 0.0, 0.0),
     (0.0, 0.0, 0.0, 0.0)
$u = (0.0, 0.0, 0.0, 0.0),
     (0.0, 0.0, 0.0, 0.0),
     (0.0, 0.0, 0.0, 0.0),
     (0.0, 0.0, 0.0, 0.0)

foreach ($k in 1..200)
{
    # LU����
    decomp $a $l $u
    # �s��̐�
    multiply $u $l $a
    # �Ίp�v�f��\��
    Write-Host ([string]::format("{0,3:D}`t", $k)) -nonewline
    disp_eigenvalue $a

    # ��������
    $e = 0.0
    foreach ($i in 1..$N)
    {
        foreach ($j in 0..($i - 1))
        {
            $e += [Math]::Abs($a[$i][$j])
        }
    }
    if ($e -lt 0.00000000001)
    {
        break
    }
}

Write-Host
Write-Host "�ŗL�l"
disp_eigenvalue $a
