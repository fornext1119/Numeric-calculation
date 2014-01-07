<?php
$ary = array_filter(range(1,9), function ($n) {return ($n % 3 == 0);});
echo array_reduce($ary, function($x, $y) {return $x + $y;}, 0);
?>
