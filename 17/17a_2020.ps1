<#

#>

$strarray = Get-Content in.txt

$currentActive = @{}

$cycleCount = 6

$imax = $strarray.Length
$jmax = $strarray[0].Length
for ($i = 0;$i -lt $imax;$i++) {
    for ($j = 0;$j -lt $jmax;$j++) {
        if ($strarray[$i][$j] -eq "#") {
            $currentActive.Add("$i $j 0",0)
        }
    }
}

for ($cycle = 0; $cycle -lt $cycleCount;$cycle++) {
    $queue = @{}
    $nextActive = @{}

    foreach ($coord in $currentActive.Keys) { # Check active lights and add inactive to check queue
        $xcoord = [int16]$coord.Substring(0,$coord.indexOf(" "))
        $ycoord = $coord.Substring($coord.indexOf(" ") + 1)
        $zcoord = [int16]$ycoord.Substring($ycoord.indexOf(" ") + 1)
        $ycoord = [int16]$ycoord.Substring(0,$ycoord.indexOf(" "))

        #Write-Host "checking $coord --- "
        $neighborCount = 0

        for ($x = $xcoord - 1;$x -lt $xcoord + 2;$x++) {
            for ($y = $ycoord - 1;$y -lt $ycoord + 2;$y++) {
                for ($z = $zcoord - 1;$z -lt $zcoord + 2;$z++) {
                    if (!(($x -eq $xcoord) -and ($y -eq $ycoord) -and ($z -eq $zcoord))) {
                        $checkCoord = "$x $y $z"

                        #Write-Host "$checkCoord"

                        if ($currentActive[$checkCoord] -eq 0) {
                            $neighborCount++
                        } elseif ($queue[$checkCoord] -ge 1) {
                            $queue[$checkCoord]++
                        } else {
                            $queue.Add($checkCoord, 1)
                        }
                    }
                }
            }
        }
        
        if (($neighborCount -eq 2) -or ($neighborCount -eq 3)) {
            #Write-Host "Keeping $coord"
            $nextActive.Add($coord,0)
        }
    }

    foreach ($coord in $queue.Keys) { # Check inactive lights in queue
        if ($queue[$coord] -eq 3) {
            #Write-Host "Turning on: $coord"
            $nextActive.Add($coord,0)
        }
    }

    $currentActive = $nextActive
}

echo $currentActive.Count