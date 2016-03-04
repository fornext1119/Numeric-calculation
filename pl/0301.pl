use strict;
use warnings;

# ‰€:a, Œö·:a ‚Å ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
sub sn
{
    my ($a, $lim) = @_;

    my $n = int($lim / $a); # €”:n  =  ãŒÀ:lim / Œö·:a
    my $l = $n * $a;        # ––€:l  =  €”:n   * Œö·:a
    ($a + $l) * $n / 2;     # ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
}

# 3 ‚Ì”{”‚Ì‡Œv
my $sum = sn(3, 999);
print $sum, "\n";
