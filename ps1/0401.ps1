$a = 5  # ���� 5
$d = 3  # ���� 3
$n = 10 # ���� 10
$p = 1  # ��

foreach ($i in 1..$n)
{
    $m = $a + ($d * ($i - 1))
    $p *= $m;
}
Write-Host $p
