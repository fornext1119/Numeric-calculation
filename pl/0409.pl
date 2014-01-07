# �g����
sub Comb
{
    my ($n, $r) = @_;

    if ($r == 0 || $r == $n)
    {
        1;
    }
    elsif ($r == 1)
    {
        $n;
    }
    else
    {
        Comb($n - 1, $r - 1) + Comb($n - 1, $r);
    }
}

# �d���g���� (�قȂ� 10 �̂��̂���d���������� 5 �Ƃ�g�����̑���)
$n = 10;
$r = 5;
print Comb($n + $r - 1, $r), "\n";
