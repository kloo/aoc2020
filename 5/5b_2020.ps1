<#
#>

$strarray = Get-Content in.txt

$seatIDs = @()

foreach ($line in $strarray) {

    $rowString = [char[]]$line.Substring(0,7)
    $colString = [char[]]$line.Substring(7,3)

    $row = 0
    $col = 0

    $rowBinary = ""
    $colBinary = ""

    foreach ($rowMove in $rowString) {
        if ($rowMove -eq "F") {
            $rowBinary += 0
        } else {
            $rowBinary += 1
        }
    }
    $row = [Convert]::ToInt32($rowBinary,2)

    foreach ($colMove in $colString) {
        if ($colMove -eq "L") {
            $colBinary += 0
        } else {
            $colBinary += 1
        }
    }
    $col = [Convert]::ToInt32($colBinary,2)

    $ID = $row * 8 + $col

    $seatIDs += $ID
}

$seatIDs = $seatIDs | sort

for ($i = 0;$i -lt $seatIDs.Length - 1; $i++) {
    if ($seatIDs[$i] -ne ($seatIDs[$i + 1] - 1)) {
        Write-Output $($seatIDs[$i] + 1)
    }
}