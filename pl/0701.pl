# �f�[�^�_�̐� - 1
use constant N => 6;

my @x = ();
my @y = ();

# 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
for $i (0..N)
{
    my $d = $i * 1.5 - 4.5;
    $x[$i] = $d;
    $y[$i] = f($d);
}

# 0.5���݂� �^�����Ă��Ȃ��l���� 
for $i (0..18)
{
    my $d  = $i * 0.5 - 4.5;
    my $d1 = f($d);
    my $d2 = lagrange($d, \@x, \@y);

    # ���̊֐��Ɣ�r
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", $d, $d1, $d2, $d1 - $d2);
}

# ���̊֐�
sub f
{
	my ($x) = @_;
    $x - ($x ** 3) / (3 * 2) + ($x ** 5) / (5 * 4 * 3 * 2);
}

# Lagrange (���O�����W��) ���
sub lagrange
{
	my ($d, $x, $y) = @_;
    my $sum = 0;
    for $i (0..N)
    {
        my $prod = $$y[$i];
        for $j (0..N)
        {
            if ($j != $i)
			{
                $prod *= ($d - $$x[$j]) / ($$x[$i] - $$x[$j]);
            }
        }
        $sum += $prod;
    }
    $sum;
}
