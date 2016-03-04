foreach ($i in 1..9)
{
    if ($i % 3 -eq 0)
    {
        Write-Host "$i, " -nonewline
    }
}
