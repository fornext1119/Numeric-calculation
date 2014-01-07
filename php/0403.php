<?php
# ŠKæ‚ð‹‚ß‚éŠÖ”
function Fact($n)
{
    if ($n <= 1)
        return 1;
    else
        return $n * Fact($n - 1);
}

# 10‚ÌŠKæ
echo Fact(10), "\n";
echo 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1, "\n";
?>
