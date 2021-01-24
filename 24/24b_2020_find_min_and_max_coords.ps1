<#
Find the Max X, Min X, Max Y, and Min Y coords

     0,-1   1,-1
-1, 0    0,0  1,0
     -1,1   0,1
#>
### PART 1 READIN
$strarray = Get-Content in.txt

$posDict = @{}

for ($i = 0;$i -lt $strarray.Length;$i++) {
    $currLine = $strarray[$i].Replace("w","w ").Replace("e", "e ").Split(" ")
    $currX = 0
    $currY = 0
    
    foreach ($direction in $currLine) {
        if ($direction -eq "ne") {       #  1,-1
            $currX++
            $currY--
        } elseif ($direction -eq "e") {  #  1, 0
            $currX++
        } elseif ($direction -eq "se") { #  0, 1
            $currY++
        } elseif ($direction -eq "nw") { #  0,-1
            $currY--
        } elseif ($direction -eq "w") {  # -1, 0
            $currX--
        } elseif ($direction -eq "sw") { # -1, 1
            $currX--
            $currY++
        }
    }

    $endCoord = "$currX,$currY"
    if ($posDict.ContainsKey($endCoord)) {
        #echo "rem $endcoord from $currLine"
        $posDict.Remove($endCoord)
    } else {
        #echo "add $endcoord"
        $posDict.Add($endCoord,$null)
    }
}

### PART 2 HANDLING

$iterations = 100

<#

     0,-1   1,-1
-1, 0    0,0  1,0
     -1,1   0,1
#>
$adjacents = @(@(0,-1),@(0,1),@(1,-1),@(1,0),@(-1,0),@(-1,1))

for ($i = 0;$i -lt $iterations;$i++) {
    $checkWhites = @{}
    $nextDict = @{}

    #[Convert]::ToInt32(x,10)
    foreach ($key in $posDict.Keys) {
        $currCoord = $key.Split(",")
        $currX = [Convert]::ToInt32($currCoord[0],10)
        $currY = [Convert]::ToInt32($currCoord[1],10)
        $currAdjacents = 0

        foreach ($adjArray in $adjacents) {
            $checkX = $currX + $adjArray[0]
            $checkY = $currY + $adjArray[1]

            $checkPos = "$checkX,$checkY"

            if ($posDict.ContainsKey($checkPos)) {
                $currAdjacents++
            } else {
                if ($checkWhites.ContainsKey($checkPos)) {
                    $checkWhites[$checkPos]++
                } else {
                    $checkWhites.Add($checkPos,1)
                }
            }
        }

        if (($currAdjacents -eq 1) -or ($currAdjacents -eq 2)) {
            $nextDict.Add($key,$null)
        }
    }

    foreach ($whiteKey in $checkWhites.Keys) {
        if ($checkWhites[$whiteKey] -eq 2) {
            $nextDict.Add($whiteKey,$null)
        }
    }

    $posDict = $nextDict
}

$maxX = 0
$minX = 0

$maxY = 0
$minY = 0

foreach ($coord in $posDict.Keys) {
    $currCoord = $coord.Split(",")
    $currX = [Convert]::ToInt32($currCoord[0],10)
    $currY = [Convert]::ToInt32($currCoord[1],10)

    if ($currX -gt $maxX) {
        $maxX = $currX
    } elseif ($currX -lt $minX) {
        $minX = $currX
    }

    if ($currY -gt $maxY) {
        $maxY = $currY
    } elseif ($currY -lt $minY) {
        $minY = $currY
    }
}

echo "x range ($minX to $maxX) y range ($minY to $maxY)"