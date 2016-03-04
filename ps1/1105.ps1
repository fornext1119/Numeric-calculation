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

# �ŗL�x�N�g����\��
function disp_eigenvector($matrix)
{
    foreach ($row in $matrix)
    {
        normarize $row
        disp_vector $row
    }
}

# ���R�r�@
function jacobi($a, $v)
{
    foreach ($k in 1..100)
    {
        # �ő�l��T��
        $max_val = 0.0
	    foreach ($i in 0..($N - 1))
	    {
		    foreach ($j in ($i + 1)..$N)
		    {
                if ($max_val -lt [Math]::Abs($a[$i][$j]))
				{
                    $max_val = [Math]::Abs($a[$i][$j])
                    $p = $i
                    $q = $j
                }
			}
        }

        # �� �����߂�
        if ([Math]::Abs($a[$p][$p] - $a[$q][$q]) -lt 0.00000000001)
		{
            # a_{pp} �� a_{qq} �̂Ƃ��A��]�p������/4�ɂ���
            $t = [Math]::PI / 4.0
			if ($a[$p][$p] -lt 0.0)
			{
	            $t = -$t
			}
		}
        else
		{
            # a_{pp} �� a_{qq} �̂Ƃ�
            $t = [Math]::Atan(2.0 * $a[$p][$q] / ($a[$p][$p] - $a[$q][$q])) / 2.0
        }

        # �� ���g���� �s�� U ���쐬���AA = U^t �~ A �~ U
        $c = [Math]::Cos($t)
        $s = [Math]::Sin($t)
        # U^t �~ A
	    foreach ($i in 0..$N)
	    {
            $t1 =  $a[$p][$i] * $c + $a[$q][$i] * $s
            $t2 = -$a[$p][$i] * $s + $a[$q][$i] * $c
            $a[$p][$i] = $t1
            $a[$q][$i] = $t2
            # �ŗL�x�N�g��
            $t1 =  $v[$p][$i] * $c + $v[$q][$i] * $s
            $t2 = -$v[$p][$i] * $s + $v[$q][$i] * $c
            $v[$p][$i] = $t1
            $v[$q][$i] = $t2
        }
        # A �~ U
	    foreach ($i in 0..$N)
	    {
            $t1 =  $a[$i][$p] * $c + $a[$i][$q] * $s
            $t2 = -$a[$i][$p] * $s + $a[$i][$q] * $c
            $a[$i][$p] = $t1
            $a[$i][$q] = $t2
        }

        # �s��̑Ίp�v�f��\�� (�ŗL�l)
     	Write-Host ([string]::format("{0,3:D}`t", $k)) -nonewline
		disp_eigenvalue $a

        # ��������
        if ($max_val -lt 0.00000000001)
		{
			break
		}
    }
}

# ���R�r�@�ŌŗL�l�����߂�

$a = (5.0, 4.0, 1.0, 1.0),
     (4.0, 5.0, 1.0, 1.0),
     (1.0, 1.0, 4.0, 2.0),
     (1.0, 1.0, 2.0, 4.0)
$v = (1.0 ,0.0 ,0.0 ,0.0),
     (0.0 ,1.0 ,0.0 ,0.0),
     (0.0 ,0.0 ,1.0 ,0.0),
     (0.0 ,0.0 ,0.0 ,1.0)

# ���R�r�@
jacobi $a $v

Write-Host
Write-Host "�ŗL�l"
disp_eigenvalue $a

Write-Host
Write-Host "�ŗL�x�N�g��"
disp_eigenvector $v
