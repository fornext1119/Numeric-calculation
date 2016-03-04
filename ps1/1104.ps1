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

# QR����
function decomp($a, $q, $r)
{
	$x = (0.0, 0.0, 0.0, 0.0)

    foreach ($k in 0..$N)
    {
	    foreach ($i in 0..$N)
	    {
            $x[$i] = $a[$i][$k]
        }
        if ($k -gt 0)
        {
    	    foreach ($j in 0..($k - 1))
    	    {
                $t = 0
    		    foreach ($i in 0..$N)
    		    {
                    $t += $a[$i][$k] * $q[$i][$j]
                }
                $r[$j][$k] = $t
                $r[$k][$j] = 0
    		    foreach ($i in 0..$N)
    		    {
                    $x[$i] -= $t * $q[$i][$j]
                }
            }
        }
        $t = 0
	    foreach ($i in 0..$N)
	    {
            $t += $x[$i] * $x[$i]
        }
        $r[$k][$k] = [Math]::Sqrt($t)
	    foreach ($i in 0..$N)
	    {
            $q[$i][$k] = $x[$i] / $r[$k][$k]
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

# QR�����ŌŗL�l�����߂�

$a = (5.0, 4.0, 1.0, 1.0),
     (4.0, 5.0, 1.0, 1.0),
     (1.0, 1.0, 4.0, 2.0),
     (1.0, 1.0, 2.0, 4.0)
$q = (0.0, 0.0, 0.0, 0.0),
     (0.0, 0.0, 0.0, 0.0),
     (0.0, 0.0, 0.0, 0.0),
     (0.0, 0.0, 0.0, 0.0)
$r = (0.0, 0.0, 0.0, 0.0),
     (0.0, 0.0, 0.0, 0.0),
     (0.0, 0.0, 0.0, 0.0),
     (0.0, 0.0, 0.0, 0.0)

foreach ($k in 1..200)
{
    # QR����
    decomp $a $q $r
    # �s��̐�
    multiply $r $q $a
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
