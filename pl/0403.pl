# �K������߂�֐�
sub Fact
{
    my ($n) = @_;

    if ($n <= 1)
    {
        1;
    }
    else
    {
        $n * Fact($n - 1);
    }
}

# 10�̊K��
print Fact(10), "\n";
print 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1, "\n";
