<#
#>

$strarray = Get-Content in.txt

$seatIDs = @()

foreach ($line in $strarray) {

    $seatString = $line

    $seatString = $seatString.Replace("F","0")
    $seatString = $seatString.Replace("B","1")

    $seatString = $seatString.Replace("L","0")
    $seatString = $seatString.Replace("R","1")

    $ID = [Convert]::ToInt32("$seatString",2)

    $seatIDs += $ID
}

$seatIDs = $seatIDs | sort

for ($i = 0;$i -lt $seatIDs.Length - 1; $i++) {
    if ($seatIDs[$i] -ne ($seatIDs[$i + 1] - 1)) {
        Write-Output $($seatIDs[$i] + 1)
    }
}