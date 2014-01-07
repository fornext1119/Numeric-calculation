use Math::Trig 'pi';

my $a = 0;
my $b = 1;

my @t = ();

# ‘äŒ`‘¥‚ÅÏ•ª
my $n = 2;
for $i (1..6)
{
    my $h = ($b - $a) / $n;
    my $s = 0;
    my $x = $a;
    for $j (1..($n - 1))
    {
        $x += $h;
        $s += f($x);
    }
    # Œ‹‰Ê‚ğ•Û‘¶
    $t[$i][1] = $h * ((f($a) + f($b)) / 2 + $s);
    $n *= 2;
}

# Richardson‚Ì•âŠO–@
$n = 4;
for $j (2..6)
{
    for $i ($j..6)
    {
        $t[$i][$j] = $t[$i][$j - 1] + ($t[$i][$j - 1] - $t[$i - 1][$j - 1]) / ($n - 1);
        if ($i == $j)
        {
            # Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
            printf("%2d : %13.10f, %13.10f\n", $j, $t[$i][$j], $t[$i][$j] - pi);
        }
    }
    $n *= 4;
}

sub f
{
    my ($x) = @_;
    4 / (1 + $x * $x);
}
