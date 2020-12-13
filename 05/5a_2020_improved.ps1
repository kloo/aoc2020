<#
#>

$strarray = Get-Content in.txt

$maxID = 0

foreach ($line in $strarray) {

    $seatString = $line

    $seatString = $seatString.Replace("F","0")
    $seatString = $seatString.Replace("B","1")

    $seatString = $seatString.Replace("L","0")
    $seatString = $seatString.Replace("R","1")

    $ID = [Convert]::ToInt32("$seatString",2)

    $maxID = [int](@($maxID,$ID) | measure -Maximum).Maximum
}

echo $maxID