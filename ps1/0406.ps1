# 階乗
function Fact($n)
{
    if ($n -le 1)
    {
        1
    }
    else
    {
        $n * (Fact ($n - 1))
    }
}

# 下降階乗冪
function FallingFact($x, $n)
{
    if ($n -le 1)
    {
        $x
    }
    else
    {
        $x * (FallingFact ($x - 1) ($n - 1))
    }
}

# 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
$n = 10
$r = 5
Write-Host ((Fact $n) / (Fact ($n - $r)))
Write-Host (FallingFact $n $r)
