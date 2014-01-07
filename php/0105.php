<?php
error_reporting(E_NOTICE);

$sum = 0;
foreach (range(1, 99) as $i)
{
    if ($i % 3 == 0)
    {
        $sum += $i;
    }
}
echo "$sum\n";
?>
