<?php
define("N", 3);

# �x�L��@�ōő�ŗL�l�����߂�
main();

function main()
{
    $a = [[5.0, 4.0, 1.0, 1.0],
          [4.0, 5.0, 1.0, 1.0],
          [1.0, 1.0, 4.0, 2.0],
          [1.0, 1.0, 2.0, 4.0]];
    $x =  [1.0, 0.0, 0.0, 0.0];

    # �x�L��@
    $lambda = power($a, $x);

    print "\neigenvalue\n";
    printf("%14.10f", $lambda);

    print "\neigenvector\n";
    disp_vector($x);
}

# �x�L��@
function power(&$a, &$x0)
{
    $lambda   = 0.0;

    # ���K�� (�x�N�g�� x0 �̒������P�ɂ���)
    normarize($x0);
    $e0 = 0.0;
    foreach (range(0, N) as $i)
    {
        $e0 += $x0[$i];
    }

    foreach (range(1, 200) as $k)
    {
        # �P�����z���\��
        printf("%3d\t", $k);
        disp_vector($x0);

        # �s��̐� x1 = A �~ x0 
        $x1 = [0.0, 0.0, 0.0, 0.0];
        foreach (range(0, N) as $i)
        {
            foreach (range(0, N) as $j)
            {
                $x1[$i] += $a[$i][$j] * $x0[$j];
            }
        }

        # ����
        $p0 = 0.0;
        $p1 = 0.0;
        foreach (range(0, N) as $i)
        {
            $p0 += $x1[$i] * $x1[$i];
            $p1 += $x1[$i] * $x0[$i];
        }
        # �ŗL�l
        $lambda = $p0 / $p1;

        # ���K�� (�x�N�g�� x1 �̒������P�ɂ���)
        normarize($x1);
        # ��������
        $e1 = 0.0;
        foreach (range(0, N) as $i)
        {
            $e1 += $x1[$i];
        }
        if (abs($e0 - $e1) < 0.00000000001) break;

        foreach (range(0, N) as $i)
        {
            $x0[$i] = $x1[$i];
        }
        $e0 = $e1;
    }

    return $lambda;
}

# �P�����z���\��
function disp_vector($row)
{
    foreach ($row as $col)
        printf("%14.10f\t", $col);
    print "\n";
}
# ���K�� (�x�N�g���̒������P�ɂ���)
function normarize(&$x)
{
    $s = 0.0;
    foreach (range(0, N) as $i)
    {
        $s += $x[$i] * $x[$i];
    }
    $s = sqrt($s);
    
    foreach (range(0, N) as $i)
    {
        $x[$i] /= $s;
    }
}
?>
