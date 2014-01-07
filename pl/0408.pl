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

# �g���� (�قȂ� 10 �̂��̂��� 5 ����Ăł���g�����̑���)
$n = 10;
$r = 5;
print Comb($n, $r), "\n";
