use Math::Trig 'pi';

my $a = 0;
my $b = 1;

# ‘äŒ`‘¥‚ÅÏ•ª
my $n = 2;
for $j (1..10)
{
    my $h = ($b - $a) / $n;
    my $s = 0;
    my $x = $a;
    for $i (1..($n - 1))
    {
        $x += $h;
        $s += f($x);
    }
    $s = $h * ((f($a) + f($b)) / 2 + $s);
    $n *= 2;

    # Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
    printf("%2d : %13.10f, %13.10f\n", $j, $s, $s - pi);
}

sub f
{
    my ($x) = @_;
    4 / (1 + $x * $x);
}
