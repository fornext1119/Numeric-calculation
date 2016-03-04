Echo (3 + 5)
Echo (3 - 5)
Echo (3 * 5)
Echo ([Math]::Pow(3, 5))
Echo (5 / 3)
Echo ([Math]::Floor(5 / 3))
Echo (5 % 3)

Echo (5 % 3)

Write-Output (3 * 5)
Write-Host   (3 * 5)

Write-Host ([string]::format("{0,3:D}`n", 3 * 5)) -nonewline
Write-Host ([string]::format("{0,23:F20}", 5 / 3))
