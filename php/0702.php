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
    $d2 = neville($d, $x, $y);

    # ���̊֐��Ɣ�r
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", $d, $d1, $d2, $d1 - $d2);
}

# ���̊֐�
function f($x)
{
    return $x - pow($x, 3) / (3 * 2) + pow($x, 5) / (5 * 4 * 3 * 2);
}

# Neville (�l���B��) ���
function neville($d, $x, $y)
{
	$w = array();
	foreach (range(0, N) as $i)
    {
        $w[0][$i] = $y[$i];
    }

	foreach (range(1, N) as $j)
    {
		foreach (range(0, N - $j) as $i)
        {
        	$w[$j][$i] = $w[$j-1][$i+1] + ($w[$j-1][$i+1] - $w[$j-1][$i]) * ($d - $x[$i+$j]) / ($x[$i+$j] - $x[$i]);
        }
    }
    return $w[N][0];
}
?>
