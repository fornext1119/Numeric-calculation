use strict;
use warnings;

my $sum = 0;
for (1..99)
{
    if ($_ % 3 == 0)
    {
        $sum += $_;
    }
}
print "$sum\n";
