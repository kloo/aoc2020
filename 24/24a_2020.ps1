<#

     0,-1   1,-1
-1, 0    0,0  1,0
     -1,1   0,1
#>

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
        echo "rem $endcoord from $currLine"
        $posDict.Remove($endCoord)
    } else {
        echo "add $endcoord"
        $posDict.Add($endCoord,$null)
    }
}

$posDict.Keys.Count

