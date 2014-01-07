for (1..9)
{
    if ($_ % 3 == 0)
    {
        print "$_, ";
    }
}
print "\n";

for (1..9)
{
    print "$_, " if ($_ % 3 == 0)
}
print "\n";

for (1..9)
{
    print "$_, " unless ($_ % 3)
}
print "\n";
