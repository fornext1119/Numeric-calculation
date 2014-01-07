$sum = 0
foreach ($i in 1..99)
{
    if ($i % 3 -eq 0)
    {
        $sum += $i
    }
}
Write-Host $sum

$sum = 0
foreach ($i in 1..99)
{
    $sum += if ($i % 3 -eq 0) {$i} else {0}
}
Write-Host $sum
