# �f�[�^�_�̐�
set-variable -option constant -name N -value 7

# ���̊֐�
function f($x)
{
    $x - [math]::pow($x, 3) / (3 * 2) + [math]::pow($x, 5) / (5 * 4 * 3 * 2)
}

# Lagrange (���O�����W��) ���
function lagrange($d, $x, $y)
{
    $sum = 0
    foreach ($i in 0..($N - 1))
    {
        $prod = $y[$i]
        foreach ($j in 0..($N - 1))
        {
            if ($j -ne $i)
			{
                $prod *= ($d - $x[$j]) / ($x[$i] - $x[$j])
            }
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
    $d = $i * 1.5 - 4.5
    $x[$i] = $d
    $y[$i] = f($d)
}

# 0.5���݂� �^�����Ă��Ȃ��l���� 
foreach ($i in 0..18)
{
    $d  = $i * 0.5 - 4.5
    $d1 = f($d)
    $d2 = (lagrange $d $x $y)

    # ���̊֐��Ɣ�r
    Write-Host ([string]::format("{0,5:F2}`t{1,8:F5}`t{2,8:F5}`t{3,8:F5}", $d, $d1, $d2, ($d1 - $d2)))
}
