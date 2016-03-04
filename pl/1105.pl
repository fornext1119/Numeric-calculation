use Math::Trig;
use constant N => 3;

# ���R�r�@�ŌŗL�l�����߂�
main();

sub main
{
	my @a = ([5.0, 4.0, 1.0, 1.0],
	         [4.0, 5.0, 1.0, 1.0],
	         [1.0, 1.0, 4.0, 2.0],
	         [1.0, 1.0, 2.0, 4.0]);
	my @v = ([1.0 ,0.0 ,0.0 ,0.0],
	         [0.0 ,1.0 ,0.0 ,0.0],
	         [0.0 ,0.0 ,1.0 ,0.0],
	         [0.0 ,0.0 ,0.0 ,1.0]);

	# ���R�r�@
	jacobi(\@a, \@v);

	print "\neigenvalue\n";
	disp_eigenvalue(\@a);

	print "\neigenvector\n";
	disp_eigenvector(\@v);
}

# ���R�r�@
sub jacobi
{
    my ($a, $v) = @_;

    for $k (1..100)
    {
        # �ő�l��T��
        $max_val = 0.0;
	    for $i (0..(N - 1))
	    {
		    for $j (($i + 1)..N)
		    {
                if ($max_val < abs($$a[$i][$j]))
				{
                    $max_val = abs($$a[$i][$j]);
                    $p = $i;
                    $q = $j;
                }
            }
        }

        # �� �����߂�
        if (abs($$a[$p][$p] - $$a[$q][$q]) < 0.00000000001)
		{
            # a_{pp} �� a_{qq} �̂Ƃ��A��]�p������/4�ɂ���
            $t = pi / 4.0;
            $t = -$t if ($$a[$p][$p] < 0.0)
		}
        else
		{
            # a_{pp} �� a_{qq} �̂Ƃ�
            $t = atan(2.0 * $$a[$p][$q] / ($$a[$p][$p] - $$a[$q][$q])) / 2.0;
        }

        # �� ���g���� �s�� U ���쐬���AA = U^t �~ A �~ U
        $c = cos($t);
        $s = sin($t);
        # U^t �~ A
	    for $i (0..N)
	    {
            $t1 =  $$a[$p][$i] * $c + $$a[$q][$i] * $s;
            $t2 = -$$a[$p][$i] * $s + $$a[$q][$i] * $c;
            $$a[$p][$i] = $t1;
            $$a[$q][$i] = $t2;
            # �ŗL�x�N�g��
            $t1 =  $$v[$p][$i] * $c + $$v[$q][$i] * $s;
            $t2 = -$$v[$p][$i] * $s + $$v[$q][$i] * $c;
            $$v[$p][$i] = $t1;
            $$v[$q][$i] = $t2;
        }
        # A �~ U
	    for $i (0..N)
	    {
            $t1 =  $$a[$i][$p] * $c + $$a[$i][$q] * $s;
            $t2 = -$$a[$i][$p] * $s + $$a[$i][$q] * $c;
            $$a[$i][$p] = $t1;
            $$a[$i][$q] = $t2;
        }

        # �s��̑Ίp�v�f��\�� (�ŗL�l)
        printf("%3d\t", $k);
		disp_eigenvalue(\@$a);

        # ��������
        last if ($max_val < 0.00000000001);
    }
}

# �Ίp�v�f��\��
sub disp_eigenvalue
{
    my ($a) = @_;
    for $i (0..N)
    {
        printf("%14.10f\t", $$a[$i][$i]);
    }
    print "\n";
}
# �ŗL�x�N�g����\��
sub disp_eigenvector
{
    my ($matrix) = @_;

    for $row (@$matrix)
    {
        normarize(\@$row);
        disp_vector(\@$row);
    }
}
# �P�����z���\��
sub disp_vector
{
    my ($x) = @_;
    for $i (0..N)
    {
        printf("%14.10f\t", $$x[$i]);
    }
    print "\n";
}
# ���K�� (�x�N�g���̒������P�ɂ���)
sub normarize
{
    my ($x) = @_;
    my  $s  = 0.0;
    for $i (0..N)
    {
        $s += $$x[$i] * $$x[$i];
    }
    $s = sqrt($s);
    
    for $i (0..N)
    {
        $$x[$i] /= $s;
    }
}
