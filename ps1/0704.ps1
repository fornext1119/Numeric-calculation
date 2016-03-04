# データ点の数
set-variable -option constant -name N   -value  7
set-variable -option constant -name Nx2 -value 14

# 元の関数
function f($x)
{
    $x - [math]::pow($x, 3) / (3 * 2) + [math]::pow($x, 5) / (5 * 4 * 3 * 2)
}
# 導関数
function fd($x)
{
    1 - [math]::pow($x, 2) / 2 + [math]::pow($x, 4) / (4 * 3 * 2)
}

# Hermite (エルミート) 補間
function hermite($d, $z, $a)
{
    $sum = $a[0]
    foreach ($i in 1..($Nx2 - 1))
    {
        $prod = $a[$i]
        foreach ($j in 0..($i - 1))
        {
            $prod *= ($d - $z[$j])
        }
        $sum += $prod
    }
    $sum
}

$x  = New-Object double[] $N
$y  = New-Object double[] $N
$yd = New-Object double[] $N

# 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
foreach ($i in 0..($N - 1))
{
    $d1      = $i * 1.5 - 4.5
    $x[$i]   = $d1
    $y[$i]   = f($d1)
    $yd[$i]  = fd($d1)
}

# 差分商の表を作る
$z = New-Object  double[]   $Nx2
$d = New-Object "double[,]" $Nx2,$Nx2
foreach ($i in 0..($Nx2 - 1))
{
    $j       = [math]::floor($i / 2)
    $z[$i]   = $x[$j]
    $d[0,$i] = $y[$j]
}
foreach ($i in 1..($Nx2 - 1))
{
	foreach ($j in 0..($Nx2 - $i - 1))
	{
	    if ($i -eq 1 -and $j % 2 -eq 0)
		{
	        $d[$i,$j] = $yd[[math]::floor($j / 2)]
		}
	    else
		{
        	$d[$i,$j] = ($d[($i-1),($j+1)] - $d[($i-1),$j]) / ($z[($j+$i)] - $z[$j])
		}
	}
}
# ｎ階差分商
$a = New-Object double[] $Nx2
foreach ($j in 0..($Nx2 - 1))
{
    $a[$j] = $d[$j,0]
}

# 0.5刻みで 与えられていない値を補間 
foreach ($i in 0..18)
{
    $d1 = $i * 0.5 - 4.5
    $d2 = f($d1)
    $d3 = (hermite $d1 $z $a)

    # 元の関数と比較
    Write-Host ([string]::format("{0,5:F2}`t{1,8:F5}`t{2,8:F5}`t{3,8:F5}", $d1, $d2, $d3, ($d2 - $d3)))
}
