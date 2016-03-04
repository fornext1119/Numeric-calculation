use strict;
use warnings;

# ����:a, ����:a �� ���:lim �̐���̑��a��Ԃ��֐�
sub sn
{
    my ($a, $lim) = @_;

    my $n = int($lim / $a); # ����:n  =  ���:lim / ����:a
    my $l = $n * $a;        # ����:l  =  ����:n   * ����:a
    ($a + $l) * $n / 2;     # ���a:sn = (����:a   + ����:l) * ����:n / 2
}

# 3 �̔{���̍��v
my $sum = sn(3, 999);
print $sum, "\n";
