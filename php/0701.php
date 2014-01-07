<?php
# �f�[�^�_�̐� - 1
define("N", 6);

$x = array();
$y = array();

# 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
foreach (range(0, N) as $i)
{
    $d = $i * 1.5 - 4.5;
    $x[$i] = $d;
    $y[$i] = f($d);
}

# 0.5���݂� �^�����Ă��Ȃ��l���� 
foreach (range(0, 18) as $i)
{
    $d  = $i * 0.5 - 4.5;
    $d1 = f($d);
    $d2 = lagrange($d, $x, $y);

    # ���̊֐��Ɣ�r
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", $d, $d1, $d2, $d1 - $d2);
}

# ���̊֐�
function f($x)
{
    return $x - pow($x, 3) / (3 * 2) + pow($x, 5) / (5 * 4 * 3 * 2);
}

# Lagrange (���O�����W��) ���
function lagrange($d, $x, $y)
{
    $sum = 0;
	foreach (range(0, N) as $i)
    {
        $prod = $y[$i];
		foreach (range(0, N) as $j)
        {
            if ($j != $i)
			{
                $prod *= ($d - $x[$j]) / ($x[$i] - $x[$j]);
            }
        }
        $sum += $prod;
    }
    return $sum;
}
?>
