$sum = 0
1..99 | where {$_ % 3 -eq 0} | foreach {$sum += $_}
$sum
