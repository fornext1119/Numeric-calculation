# �K��
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

# ���~�K��p
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

# ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
$n = 10
$r = 5
Write-Host ((Fact $n) / (Fact ($n - $r)))
Write-Host (FallingFact $n $r)
