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

# �Q�����z���\��
function disp_matrix($matrix)
{
    foreach ($row in $matrix)
	{
	    foreach ($col in $row)
	    {
	        Write-Host ([String]::Format("{0,14:F10}", $col)) -nonewline
	    }
	    Write-Host
    }
}

# �n�E�X�z���_�[�ϊ�
function tridiagonalize($a, $d, $e)
{
    $v = (0.0 ,0.0 ,0.0 ,0.0)

    foreach ($k in 0..($N - 2))
	{
        $d[$k] = $a[$k][$k]
        $t     = 0.0
        $w     = (0.0, 0.0, 0.0, 0.0)
        foreach ($i in ($k + 1)..$N)
		{
            $w[$i] = $a[$i][$k]
            $t += ($w[$i] * $w[$i])
        }
        $s = [Math]::Sqrt($t) 
        if ($w[$k + 1] -lt 0)
		{
            $s = -$s
        }

        if ([Math]::Abs($s) -lt 0.00000000001)
		{
            $e[$k + 1] = 0.0
		}
        else
		{
            $e[$k + 1] = -$s
            $w[$k + 1] += $s
            $s = 1 / [Math]::Sqrt($w[$k + 1] * $s)
            foreach ($i in ($k + 1)..$N)
			{
                $w[$i] *= $s
            }

            foreach ($i in ($k + 1)..$N)
			{
                $s = 0.0
                foreach ($j in ($k + 1)..$N)
				{
                    if ($j -le $i)
					{
                        $s += $a[$i][$j] * $w[$j]
					}
                    else
					{
                        $s += $a[$j][$i] * $w[$j]
                    }
                }
                $v[$i] = $s
            }

            $s = 0
            foreach ($i in ($k + 1)..$N)
			{
                $s += $w[$i] * $v[$i]
            }

            $s /= 2
            foreach ($i in ($k + 1)..$N)
			{
                $v[$i] -= $s * $w[$i]
            }
            foreach ($i in ($k + 1)..$N)
			{
                foreach ($j in ($k + 1)..$i)
				{
                    $a[$i][$j] -= $w[$i] * $v[$j] + $w[$j] * $v[$i]
                }
            }
            # ���̍s�͌ŗL�x�N�g�������߂Ȃ��Ȃ�s�v
            foreach ($i in ($k + 1)..$N)
			{
                $a[$i][$k] = $w[$i]
            }
        } 
    }

    $d[$N - 1] = $a[$N - 1][$N - 1]
    $d[$N]     = $a[$N][$N]
    
    $e[0]      = 0.0  
    $e[$N]     = $a[$N][$N - 1]
    
    # ���̍s�͌ŗL�x�N�g�������߂Ȃ��Ȃ�s�v
    foreach ($k in ($N..0))
	{
        $w     = (0.0, 0.0, 0.0, 0.0)
        if ($k -lt ($N - 1))
		{
            foreach ($i in ($k + 1)..$N)
			{
                $w[$i] = $a[$i][$k]
            }
            foreach ($i in ($k + 1)..$N)
			{
                $s = 0.0
                foreach ($j in ($k + 1)..$N)
				{
                    $s += $a[$i][$j] * $w[$j]
                }
                $v[$i] = $s
            }
            foreach ($i in ($k + 1)..$N)
			{
                foreach ($j in ($k + 1)..$N)
				{
                    $a[$i][$j] -= $v[$i] * $w[$j]
                }
            }
        }
        foreach ($i in 0..$N)
		{
            $a[$i][$k] = 0.0
        }
        $a[$k][$k] = 1.0
    }
}

# QR����
function decomp($a, $d, $e)
{
    $e[0] = 1.0
    $h = $N
    while ([Math]::Abs($e[$h]) -lt 0.00000000001)
	{
        $h--
    }

    while ($h -gt 0)
	{
        $e[0] = 0.0
        $l = $h - 1
        while ([Math]::Abs($e[$l]) -ge 0.00000000001)
		{
            $l--
        }
        foreach ($j in 1..100)
		{
            $w = ($d[$h - 1] - $d[$h]) / 2.0
            $s = [Math]::Sqrt($w * $w + $e[$h] * $e[$h])
            if ($w -lt 0.0)
			{
                $s = - $s
            }

            $x = $d[$l] - $d[$h] + $e[$h] * $e[$h] / ($w + $s)
            $y = $e[$l + 1]
            $z = 0.0
            foreach ($k in $l..($h - 1))
			{
                if ([Math]::Abs($x) -ge [Math]::Abs($y))
				{
                    $t = -$y / $x  
                    $u = 1 / [Math]::Sqrt($t * $t + 1.0)
                    $s = $t * $u
				}
                else
				{
                    $t = -$x / $y
                    $s = 1 / [Math]::Sqrt($t * $t + 1.0)  
                    if ($t -lt 0)
					{
                        $s = -$s
                    }
                    $u = $t * $s
                }
                $w = $d[$k] - $d[$k + 1]
                $t = ($w * $s + 2 * $u * $e[$k + 1]) * $s
                $d[$k    ] = $d[$k    ] - $t  
                $d[$k + 1] = $d[$k + 1] + $t
                $e[$k    ] = $u * $e[$k] - $s * $z
                $e[$k + 1] = $e[$k + 1] * ($u * $u - $s * $s) + $w * $s * $u

                # ���̍s�͌ŗL�x�N�g�������߂Ȃ��Ȃ�s�v
                foreach ($i in 0..$N)
				{
                    $x = $a[$k    ][$i]  
                    $y = $a[$k + 1][$i]
                    $a[$k    ][$i] = $u * $x - $s * $y  
                    $a[$k + 1][$i] = $s * $x + $u * $y
                }

                if ($k -lt $N - 1)
				{
                    $x = $e[$k + 1]  
                    $y = -$s * $e[$k + 2]  
                    $z = $y
                    $e[$k + 2] = $u * $e[$k + 2]
                }
            }

     		Write-Host ([string]::format("{0,3:D}`t", $j)) -nonewline
			disp_vector $d

	        # ��������
			if ([Math]::Abs($e[$h]) -lt 0.00000000001)
			{
				break
			}
        }

        $e[0] = 1.0  
        while ([Math]::Abs($e[$h]) -lt 0.00000000001)
		{
            $h--
        }
    }

    # ���̍s�͌ŗL�x�N�g�������߂Ȃ��Ȃ�s�v
    foreach ($k in 0..($N - 1))
	{
        $l = $k
        foreach ($i in ($k + 1)..$N) 
		{
            if ($d[$i] -gt $d[$l])
			{ 
                $l = $i
            }
        }

        $t    = $d[$k]  
        $d[$k] = $d[$l]  
        $d[$l] = $t

		foreach ($i in 0..$N)
		{
	        $t       = $a[$k][$i]  
	        $a[$k][$i] = $a[$l][$i]  
	        $a[$l][$i] = $t
        }
    }
}

# �n�E�X�z���_�[�ϊ���QR�����ŌŗL�l�����߂�
$a = (5.0, 4.0, 1.0, 1.0),
     (4.0, 5.0, 1.0, 1.0),
     (1.0, 1.0, 4.0, 2.0),
     (1.0, 1.0, 2.0, 4.0)
$d = (0.0 ,0.0 ,0.0 ,0.0)
$e = (0.0 ,0.0 ,0.0 ,0.0)

# �n�E�X�z���_�[�ϊ�
tridiagonalize $a $d $e
disp_matrix $a

# QR����
Write-Host
Write-Host "QR����"
decomp $a $d $e

Write-Host
Write-Host "�ŗL�l"
disp_vector $d

Write-Host
Write-Host "�ŗL�x�N�g��"
disp_matrix $a
