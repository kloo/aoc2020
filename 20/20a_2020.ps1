<#
#>

$strarray = Get-Content in.txt

$width = $strarray[1].Length
$height = $width

$answer = [int64] 1

$iterIncVal = $height + 2
$rowIncVal = $height - 1

$sideCount = New-Object int[] ([Math]::Pow(2,$width))

$tileHash = @{}

for ($i = 1;$i -lt $strarray.Count;$i += $iterIncVal) {
    $currGrid = $strarray[$i..($i + $rowIncVal)]
    
    $topString = $currGrid[0].Replace("#","1").Replace(".","0")
    $topRow = [Convert]::ToInt16($topString,2)
    
    $topStringRev = $topString.ToCharArray()
    [array]::Reverse($topStringRev)
    $topStringRev = -join($topStringRev)
    $topRowRev = [Convert]::ToInt16($topStringRev,2)

    $bottomString = $currGrid[-1].Replace("#","1").Replace(".","0")
    $bottomRow = [Convert]::ToInt16($bottomString,2)

    $bottomStringRev = $bottomString.ToCharArray()
    [array]::Reverse($bottomStringRev)
    $bottomStringRev = -join($bottomStringRev)
    $bottomRowRev = [Convert]::ToInt16($bottomStringRev,2)

    $leftString = ""
    $rightString = ""
    for ($j = 0;$j -lt $height;$j++) {
        $leftString += $currGrid[$j][0]
        $rightString += $currGrid[$j][-1]
    }
    $leftString = $leftString.Replace("#","1").Replace(".","0")
    $rightString = $rightString.Replace("#","1").Replace(".","0")

    $leftStringRev = $leftString.ToCharArray()
    [array]::Reverse($leftStringRev)
    $leftStringRev = -join($leftStringRev)
    $leftRowRev = [Convert]::ToInt16($leftStringRev,2)

    $rightStringRev = $rightString.ToCharArray()
    [array]::Reverse($rightStringRev)
    $rightStringRev = -join($rightStringRev)
    $rightRowRev = [Convert]::ToInt16($rightStringRev,2)
    
    $leftCol = [Convert]::ToInt16($leftString,2)
    $rightCol = [Convert]::ToInt16($rightString,2)
    $leftColRev = [Convert]::ToInt16($leftStringRev,2)
    $rightColRev = [Convert]::ToInt16($rightStringRev,2)

    $sideCount[$topRow]++
    $sideCount[$bottomRow]++
    $sideCount[$topRowRev]++
    $sideCount[$bottomRowRev]++

    $sideCount[$leftCol]++
    $sideCount[$rightCol]++
    $sideCount[$leftColRev]++
    $sideCount[$rightColRev]++

    $tileID = $strarray[$i - 1]
    $tileID = $tileID.Substring($tileID.IndexOf(" ") + 1,4)
    $tileHash.Add($tileID,@($topRow,$bottomRow,$leftCol,$rightCol))

    #Generate output for adjacency finding
    #Write-Output "$tileID : $topRow $topRowRev $bottomRow $bottomRowRev $leftCol $leftColRev $rightCol $rightColRev" >> TileIDs.txt
}

#[convert]::ToInt32($item,10)

foreach ($tileID in $tileHash.Keys) {
    $currTile = $tileHash[$tileID]
    $unmatchedSides = 0

    for ($i = 0; $i -lt $currTile.Count;$i++) {
        $currValue = $currTile[$i]

        
        if ($sideCount[$currValue] -eq 1) {
            $unmatchedSides++
        }
    }

    if ($unmatchedSides -eq 2) {
            echo $tileID
            $answer *= [convert]::ToInt64($tileID,10)
    }
}

echo $answer