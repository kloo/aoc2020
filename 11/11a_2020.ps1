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
                if ($i -gt 0) { #check upper row
                    $validation += $oldArray[$lessI][$j]
                    if ($j -gt 0) {
                        $validation += $oldArray[$lessI][$lessJ]
                    }
                    if ($j -lt ($width - 1)) {
                        $validation += $oldArray[$lessI][$moreJ]
                    }
                }
                if ($i -lt ($height - 1)) { #check bottom row
                    $validation += $oldArray[$moreI][$j]
                    if ($j -gt 0) {
                        $validation += $oldArray[$moreI][$lessJ]
                    }
                    if ($j -lt ($width - 1)) {
                        $validation += $oldArray[$moreI][$moreJ]
                    }
                }
                if ($j -gt 0) {
                        $validation += $oldArray[$i][$lessJ]
                }
                if ($j -lt ($width - 1)) {
                    $validation += $oldArray[$i][$moreJ]
                }

                if (!$validation.Contains("#")) {
                    $newarray[$i] = $newArray[$i].Substring(0,$j) + "#" + $newArray[$i].Substring($j + 1)
                    $changes++
                    $occupied++
                }
            } elseif ($currSpot -eq "#") {
                $validation = ""
                if ($i -gt 0) { #check upper row
                    $validation += $oldArray[$lessI][$j]
                    if ($j -gt 0) {
                        $validation += $oldArray[$lessI][$lessJ]
                    }
                    if ($j -lt ($width - 1)) {
                        $validation += $oldArray[$lessI][$moreJ]
                    }
                }
                if ($i -lt ($height - 1)) { #check bottom row
                    $validation += $oldArray[$moreI][$j]
                    if ($j -gt 0) {
                        $validation += $oldArray[$moreI][$lessJ]
                    }
                    if ($j -lt ($width - 1)) {
                        $validation += $oldArray[$moreI][$moreJ]
                    }
                }
                if ($j -gt 0) {
                        $validation += $oldArray[$i][$lessJ]
                }
                if ($j -lt ($width - 1)) {
                    $validation += $oldArray[$i][$moreJ]
                }

                if ($validation.Contains("#")) {
                    
                    $validation = $validation.Replace("L","")
                    $validation = $validation.Replace(".","")
                    
                    if ($validation.Length -ge 4) {
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
    echo "-------------"#>
    if ($changes -eq 0) {
        $shiftSeats = $false
    } else {
        $oldArray = $newarray.Clone()
    }
}

echo $occupied