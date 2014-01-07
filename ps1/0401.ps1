$a = 5  # ‰€ 5
$d = 3  # Œö· 3
$n = 10 # €” 10
$p = 1  # Ï

foreach ($i in 1..$n)
{
    $m = $a + ($d * ($i - 1))
    $p *= $m;
}
Write-Host $p
