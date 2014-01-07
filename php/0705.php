<?php
# �f�[�^�_�̐� - 1
define("N", 6);

$x = array();
$y = array();

# 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
foreach (range(0, N) as $i)
{
    $d1 = $i * 1.5 - 4.5;
    $x[$i] = $d1;
    $y[$i] = f($d1);
}

# �R���������̌W���̕\�����
$a = array();
$b = array();
$c = array();
$d = array();
foreach (range(1, N - 1) as $i)
{
    $a[$i] =         $x[$i]   - $x[$i-1]; 
    $b[$i] = 2.0 *  ($x[$i+1] - $x[$i-1]); 
    $c[$i] =         $x[$i+1] - $x[$i]; 
    $d[$i] = 6.0 * (($y[$i+1] - $y[$i]) / ($x[$i+1] - $x[$i]) - ($y[$i] - $y[$i-1]) / ($x[$i] - $x[$i-1]));
}
# �R�������������� (�g�|�}�X�@)
$g = array();
$s = array();
$g[1] = $b[1];
$s[1] = $d[1];
foreach (range(2, N - 1) as $i)
{
    $g[$i] = $b[$i] - $a[$i] * $c[$i-1] / $g[$i-1];
    $s[$i] = $d[$i] - $a[$i] * $s[$i-1] / $g[$i-1];
}
$z = array();
$z[0] = 0;
$z[N] = 0;
$z[N-1] = $s[N-1] / $g[N-1];
for ($i = N - 2; $i >= 1; $i--)
{
    $z[$i] = ($s[$i] - $c[$i] * $z[$i+1]) / $g[$i];
}

# 0.5���݂� �^�����Ă��Ȃ��l���� 
foreach (range(0, 18) as $i)
{
    $d1 = $i * 0.5 - 4.5;
    $d2 = f($d1);
    $d3 = spline($d1, $x, $y, $z);

    # ���̊֐��Ɣ�r
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", $d1, $d2, $d3, $d2 - $d3);
}

# ���̊֐�
function f($x)
{
    return $x - pow($x, 3) / (3 * 2) + pow($x, 5) / (5 * 4 * 3 * 2);
}

# Spline (�X�v���C��) ���
function spline($d, $x, $y, $z)
{
    # ��Ԋ֐��l���ǂ̋�Ԃɂ��邩
    $k = -1;
	foreach (range(1, N) as $i)
	{
        if ($d <= $x[$i])
        {
            $k = $i - 1;
            break;
        }
    }
    if ($k < 0) $k = N;

    $d1 = $x[$k+1] - $d;
    $d2 = $d       - $x[$k];
    $d3 = $x[$k+1] - $x[$k];
    return ($z[$k] * pow($d1, 3) + $z[$k+1] * pow($d2, 3)) / (6.0 * $d3) +
           ($y[$k]   / $d3 - $z[$k]   * $d3 / 6.0) * $d1 + 
           ($y[$k+1] / $d3 - $z[$k+1] * $d3 / 6.0) * $d2;
}
?>
