# �f�[�^�_�̐�
set-variable -option constant -name N -value 7

# ���̊֐�
function f($x)
{
    $x - [math]::pow($x, 3) / (3 * 2) + [math]::pow($x, 5) / (5 * 4 * 3 * 2)
}

# Neville (�l���B��) ���
function neville($d, $x, $y)
{
    $w = New-Object "double[,]" $N,$N
    foreach ($i in 0..($N - 1))
	{
        $w[0,$i] = $y[$i]
	}
    foreach ($j in 1..($N - 1))
    {
	    foreach ($i in 0..($N - $j - 1))
	    {
			$w[$j, $i] = $w[($j-1),($i+1)] + ($w[($j-1),($i+1)] - $w[($j-1),$i]) * ($d - $x[($i+$j)]) / ($x[($i+$j)] - $x[$i])
		}
	}
	$w[($N-1),0]
}

$x = New-Object double[] $N
$y = New-Object double[] $N

# 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
foreach ($i in 0..($N - 1))
{
    $d = $i * 1.5 - 4.5
    $x[$i] = $d
    $y[$i] = f($d)
}

# 0.5���݂� �^�����Ă��Ȃ��l���� 
foreach ($i in 0..18)
{
    $d  = $i * 0.5 - 4.5
    $d1 = f($d)
    $d2 = (neville $d $x $y)

    # ���̊֐��Ɣ�r
    Write-Host ([string]::format("{0,5:F2}`t{1,8:F5}`t{2,8:F5}`t{3,8:F5}", $d, $d1, $d2, ($d1 - $d2)))
}
