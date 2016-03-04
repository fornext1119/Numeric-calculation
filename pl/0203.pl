use List::Util;
print List::Util::reduce {$a + $b} grep {$_ % 3 == 0} 1..99
print List::Util::sum grep {$_ % 3 == 0} 1..99
