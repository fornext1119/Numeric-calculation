use Math::Trig 'pi';

my $a = 0;
my $b = 1;

# ’†“_‘¥‚ÅÏ•ª
my $n = 2;
for $j (1..10)
{
    my $h = ($b - $a) / $n;
    my $s = 0;
    my $x = $a + ($h / 2);
    for $i (1..$n)
    {
        $s += f($x);
        $x += $h;
    }
    $s *= $h;
    $n *= 2;

    # Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
    printf("%2d : %13.10f, %13.10f\n", $j, $s, $s - pi);
}

sub f
{
    my ($x) = @_;
    4 / (1 + $x * $x);
}
