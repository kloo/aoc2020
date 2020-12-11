<#
 Yes I really should've thrown building the validation string into a function
#>

$strarray = Get-Content in.txt

$occupied = 0

$shiftSeats = $true

$height = $strarray.Count
$width = $strarray[0].Length

$oldArray = $strarray.Clone()
$newArray = $strarray.Clone()


while ($shiftSeats) {
    $changes = 0

    for ($i = 0;$i -lt $height;$i++) {
        for ($j = 0;$j -lt $width;$j++) {
            $currSpot = $oldArray[$i][$j]

            $lessI = $i - 1
            $moreI = $i + 1

            $lessJ = $j - 1
            $moreJ = $j + 1

            if ($currSpot -eq "L") {
                $validation = ""

                #Upper Left Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sI--
                    $sJ--
                    if (($sI -lt 0) -or ($sJ -lt 0)) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Upper Straight Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sI--
                    if (($sI -lt 0)) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Upper Right Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sI--
                    $sJ++
                    if (($sI -lt 0) -or ($sJ -gt ($width - 1))) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Same Left Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sJ--
                    if ($sJ -lt 0) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Same Right Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sJ++
                    if ($sJ -gt ($width - 1)) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Lower Left Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sI++
                    $sJ--
                    if (($sI -gt ($height - 1)) -or ($sJ -lt 0)) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Lower Straight Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sI++
                    if ($sI -gt ($height - 1)) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Lower Right Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sI++
                    $sJ++
                    if (($sI -gt ($height - 1)) -or ($sJ -gt ($width - 1))) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                if (!$validation.Contains("#")) {
                    $newarray[$i] = $newArray[$i].Substring(0,$j) + "#" + $newArray[$i].Substring($j + 1)
                    $changes++
                    $occupied++
                }
            } elseif ($currSpot -eq "#") {
                $validation = ""

                #Upper Left Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sI--
                    $sJ--
                    if (($sI -lt 0) -or ($sJ -lt 0)) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Upper Straight Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sI--
                    if (($sI -lt 0)) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Upper Right Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sI--
                    $sJ++
                    if (($sI -lt 0) -or ($sJ -gt ($width - 1))) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Same Left Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sJ--
                    if ($sJ -lt 0) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Same Right Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sJ++
                    if ($sJ -gt ($width - 1)) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Lower Left Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sI++
                    $sJ--
                    if (($sI -gt ($height - 1)) -or ($sJ -lt 0)) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Lower Straight Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sI++
                    if ($sI -gt ($height - 1)) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                #Lower Right Search
                $searchSeat = $true
                $sI = $i
                $sJ = $j
                while ($searchSeat) {
                    $sI++
                    $sJ++
                    if (($sI -gt ($height - 1)) -or ($sJ -gt ($width - 1))) {
                        break
                    } elseif ($oldArray[$sI][$sJ] -match "[L#]") {
                        $searchSeat = $false
                        $validation += $oldArray[$sI][$sJ]
                    }
                }

                if ($validation.Contains("#")) {
                    
                    $validation = $validation.Replace("L","")
                    $validation = $validation.Replace(".","")
                    
                    if ($validation.Length -ge 5) {
                        $newarray[$i] = $newArray[$i].Substring(0,$j) + "L" + $newArray[$i].Substring($j + 1)
                        $changes++
                        $occupied--
                    }
                }
            }
        }
    }
    <#
    echo "OLD"
    echo $oldArray
    echo "NEW"
    echo $newArray
    echo "-------------" #>
    if ($changes -eq 0) {
        $shiftSeats = $false
    } else {
        $oldArray = $newarray.Clone()
    }
}

echo $occupied