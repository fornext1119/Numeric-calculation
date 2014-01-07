# 組合せ
function Comb($n, $r)
{
    if (($r -eq 0) -or ($r -eq $n))
    {
        1
    }
    elseif ($r -eq 1)
    {
        $n
    }
    else
    {
        (Comb ($n - 1) ($r - 1)) + (Comb ($n - 1) $r)
    }
}

# 組合せ (異なる 10 個のものから 5 個取ってできる組合せの総数)
$n = 10
$r = 5
Write-Host (Comb $n $r)
