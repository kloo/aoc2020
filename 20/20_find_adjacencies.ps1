<#
    Generate output for adjacency finding
#>

$strarray = Get-Content TileIDs.txt

$outfile = "adjacencies.txt"

$tileTable = [ordered]@{}

foreach ($line in $strarray) {
    $tileID = $line.Substring(0,4)

    $sides = $line.Substring(7).Split(" ")

    $matchArray = @()

    foreach ($side in $sides) {
        $matching = $strarray -match " $($side)\b"

        $matchTile = $null
        if ($matching.Count -gt 1) {
            foreach ($tile in $matching) {
                $currTile = $tile.Substring(0,4)

                if (($currTile -ne $tileID) -and !($matchArray.Contains($currTile))) {
                    $matchArray += $currTile
                }
            }
        }
    }

    $tileTable.Add($tileID,$matchArray)
}

$mykeys = $tileTable.Keys | Sort
Clear-Content $outfile
foreach ($key in $mykeys) {
    Write-Output "$($key): $($tileTable[$key])" >> $outfile
}