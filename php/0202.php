<?php
$ary = array_filter(range(1,9), function ($n) {return ($n % 3 == 0);});
array_map(function ($n) {echo $n, ",";}, $ary);
?>
