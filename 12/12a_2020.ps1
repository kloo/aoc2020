<#

#>

$strarray = Get-Content in.txt

$xcoord = 0
$ycoord = 0
$face = 1
$cardinals = @("N","E","S","W")

foreach ($line in $strarray) {
    $num = [int]$line.Substring(1)
    $dir = $line.Substring(0,1)

    if ($dir -eq "F") {
        $dir = $cardinals[$face]
    }

    if ($dir -eq "L") {
        $num = $num / 90
        $face -= $num
        $face = $face % $cardinals.Count
    } elseif ($dir -eq "R") {
        $num = $num / 90
        $face += $num
        $face = $face % $cardinals.Count
    } elseif ($dir -eq "N") {
        $ycoord += $num
    } elseif ($dir -eq "S") {
        $ycoord -= $num
    } elseif ($dir -eq "E") {
        $xcoord += $num
    } elseif ($dir -eq "W") {
        $xcoord -= $num
    }

    echo "$line $xcoord $ycoord $($cardinals[$face])"
}

$xcoord = [math]::Abs($xcoord)
$ycoord = [math]::Abs($ycoord)

echo $($xcoord + $ycoord)