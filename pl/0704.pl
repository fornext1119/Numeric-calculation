# �f�[�^�_�̐� - 1
use constant N   =>  6;
use constant Nx2 => 13;

my @x  = ();
my @y  = ();
my @yd = ();

# 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
for $i (0..N)
{
    my $d1  = $i * 1.5 - 4.5;
    $x[$i]  = $d1;
    $y[$i]  = f($d1);
    $yd[$i] = fd($d1);
}

# �������̕\�����
my @z = ();
my @d = ();
for $i (0..Nx2)
{
	$j        = int($i / 2);
    $z[$i]    = $x[$j];
    $d[0][$i] = $y[$j];
}
for $i (1..Nx2)
{
	for $j (0..(Nx2 - $i))
	{
        if ($i == 1 && $j % 2 == 0)
        {
            $d[$i][$j] = $yd[int($j / 2)];
        }
        else
        {
        	$d[$i][$j] = ($d[$i-1][$j+1] - $d[$i-1][$j]) / ($z[$j+$i] - $z[$j]);
        }
    }
}

# ���K������
my @a = ();
for $j (0..Nx2)
{
    $a[$j] = $d[$j][0];
}
# 0.5���݂� �^�����Ă��Ȃ��l���� 
for $i (0..18)
{
    my $d1 = $i * 0.5 - 4.5;
    my $d2 = f($d1);
    my $d3 = hermite($d1, \@z, \@a);

    # ���̊֐��Ɣ�r
    printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", $d1, $d2, $d3, $d2 - $d3);
}

# ���̊֐�
sub f
{
	my ($x) = @_;
    $x - ($x ** 3) / (3 * 2) + ($x ** 5) / (5 * 4 * 3 * 2);
}
# ���֐�
sub fd
{
	my ($x) = @_;
    1 - ($x ** 2) / 2 + ($x ** 4) / (4 * 3 * 2);
}

# Hermite (�G���~�[�g) ���
sub hermite
{
	my ($d, $z, $a) = @_;
    my $sum = $$a[0];
    for $i (1..Nx2)
    {
        my $prod = $$a[$i];
        for $j (0..($i - 1))
        {
            $prod *= ($d - $$z[$j]);
        }
        $sum += $prod;
    }
    $sum;
}
