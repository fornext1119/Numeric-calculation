# �f�[�^�_�̐�
set-variable -option constant -name N -value 7

# ���̊֐�
function f($x)
{
    $x - [math]::pow($x, 3) / (3 * 2) + [math]::pow($x, 5) / (5 * 4 * 3 * 2)
}

# Spline (�X�v���C��) ���
function spline($d, $x, $y, $z)
{
    # ��Ԋ֐��l���ǂ̋�Ԃɂ��邩
    $k = -1
	foreach ($i in 1..($N - 1))
	{
        if ($d -le $x[$i])
        {
            $k = $i - 1
            break
        }
    }
    if ($k -lt 0)
	{
		$k = $N - 1
	}

    $d1 = $x[($k+1)] - $d
    $d2 = $d         - $x[$k]
    $d3 = $x[($k+1)] - $x[$k]
    ($z[$k] * [math]::pow($d1,3) + $z[($k+1)] * [math]::pow($d2,3)) / (6.0 * $d3) +
    ($y[$k]     / $d3 - $z[$k]     * $d3 / 6.0) * $d1 + 
    ($y[($k+1)] / $d3 - $z[($k+1)] * $d3 / 6.0) * $d2
}

$x = New-Object double[] $N
$y = New-Object double[] $N

# 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
foreach ($i in 0..($N - 1))
{
    $d1 = $i * 1.5 - 4.5
    $x[$i] = $d1
    $y[$i] = f($d1)
}

# �R���������̌W���̕\�����
$a = New-Object double[] $N
$b = New-Object double[] $N
$c = New-Object double[] $N
$d = New-Object double[] $N
foreach ($i in 1..($N - 2))
{
    $a[$i] =         $x[$i]     - $x[($i-1)] 
    $b[$i] = 2.0 *  ($x[($i+1)] - $x[($i-1)]) 
    $c[$i] =         $x[($i+1)] - $x[$i] 
    $d[$i] = 6.0 * (($y[($i+1)] - $y[$i]) / ($x[($i+1)] - $x[$i]) - ($y[$i] - $y[($i-1)]) / ($x[$i] - $x[($i-1)]))
}
# �R�������������� (�g�|�}�X�@)
$g = New-Object double[] $N
$s = New-Object double[] $N
$g[1] = $b[1]
$s[1] = $d[1]
foreach ($i in 2..($N - 2))
{
    $g[$i] = $b[$i] - $a[$i] * $c[($i-1)] / $g[($i-1)]
    $s[$i] = $d[$i] - $a[$i] * $s[($i-1)] / $g[($i-1)]
}
$z = New-Object double[] $N
$z[0] = 0
$z[($N-1)] = 0
$z[($N-2)] = $s[($N-2)] / $g[($N-2)]
for ($i = $N - 3; $i -ge 1; $i--)
{
    $z[$i] = ($s[$i] - $c[$i] * $z[($i+1)]) / $g[$i]
}

# 0.5���݂� �^�����Ă��Ȃ��l���� 
foreach ($i in 0..18)
{
    $d1 = $i * 0.5 - 4.5
    $d2 = f($d1)
    $d3 = (spline $d1 $x $y $z)

    # ���̊֐��Ɣ�r
    Write-Host ([string]::format("{0,5:F2}`t{1,8:F5}`t{2,8:F5}`t{3,8:F5}", $d1, $d2, $d3, ($d2 - $d3)))
}
