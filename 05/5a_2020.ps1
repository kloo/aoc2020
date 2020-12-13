<#
#>

$strarray = Get-Content in.txt

$maxID = 0

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

    echo "$ID, $col, $row, $colString"

    $ID = $row * 8 + $col

    $maxID = [int](@($maxID,$ID) | measure -Maximum).Maximum
}

echo $maxID