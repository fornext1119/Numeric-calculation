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

# 重複組合せ (異なる 10 個のものから重複を許して 5 個とる組合せの総数)
$n = 10
$r = 5
Write-Host (Comb ($n + $r - 1) $r)
