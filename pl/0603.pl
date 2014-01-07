use Math::Trig 'pi';

my $a = 0;
my $b = 1;

# Simpson‘¥‚ÅÏ•ª
my $n = 2;
for $j (1..5)
{
    my $h  = ($b - $a) / $n;
    my $s2 = 0;
    my $s4 = 0;
    my $x  = $a + $h;
    for $i (1..($n / 2))
    {
        $s4 += f($x);
        $x  += $h;
        $s2 += f($x);
        $x  += $h;
    }
    $s2 = ($s2 - f($b)) * 2 + f($a) + f($b);
    $s4 *= 4;
    my $s = ($s2 + $s4) * $h / 3;
    $n *= 2;

    # Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
    printf("%2d : %13.10f, %13.10f\n", $j, $s, $s - pi);
}

sub f
{
    my ($x) = @_;
    4 / (1 + $x * $x);
}
