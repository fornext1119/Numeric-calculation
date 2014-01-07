# �f�[�^�_�̐�
set-variable -option constant -name N -value 7

# ���̊֐�
function f($x)
{
    $x - [math]::pow($x, 3) / (3 * 2) + [math]::pow($x, 5) / (5 * 4 * 3 * 2)
}

# Newton (�j���[�g��) ���
function newton($d, $x, $a)
{
    $sum = $a[0]
    foreach ($i in 1..($N - 1))
    {
        $prod = $a[$i]
        foreach ($j in 0..($i - 1))
        {
            $prod *= ($d - $x[$j])
        }
        $sum += $prod
    }
    $sum
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

# �������̕\�����
$d = New-Object "double[,]" $N,$N
foreach ($j in 0..($N - 1))
{
    $d[0,$j] = $y[$j]
}
foreach ($i in 1..($N - 1))
{
	foreach ($j in 0..($N - $i - 1))
	{
        $d[$i,$j] = ($d[($i-1),($j+1)] - $d[($i-1),$j]) / ($x[($j+$i)] - $x[$j])
	}
}
# ���K������
$a = New-Object double[] $N
foreach ($j in 0..($N - 1))
{
    $a[$j] = $d[$j,0]
}

# 0.5���݂� �^�����Ă��Ȃ��l���� 
foreach ($i in 0..18)
{
    $d1 = $i * 0.5 - 4.5
    $d2 = f($d1)
    $d3 = (newton $d1 $x $a)

    # ���̊֐��Ɣ�r
    Write-Host ([string]::format("{0,5:F2}`t{1,8:F5}`t{2,8:F5}`t{3,8:F5}", $d1, $d2, $d3, ($d2 - $d3)))
}
