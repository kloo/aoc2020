<#
  Improvements: Change waypoint coord from absolute position to relative simplifying a lot of math
#>

$strarray = Get-Content in.txt

$wxcoord = 10
$wycoord = 1

$sxcoord = 0
$sycoord = 0

foreach ($line in $strarray) {
    $num = [int]$line.Substring(1)
    $dir = $line.Substring(0,1)

    if ($dir -eq "F") {
        $xmove = ($wxcoord - $sxcoord) * $num
        $ymove = ($wycoord - $sycoord) * $num

        $wxcoord += $xmove
        $wycoord += $ymove
        $sxcoord += $xmove
        $sycoord += $ymove
    } elseif ($dir -eq "L") {
        
    echo "$line    SHIP: $sxcoord $sycoord      WP: $wxcoord $wycoord"
        if ($num -eq 90) {
            $newwxcoord = $sxcoord - ($wycoord - $sycoord)
            $wycoord = $sycoord + ($wxcoord - $sxcoord)
            $wxcoord = $newwxcoord
        } elseif ($num -eq 180) {
            $newwxcoord = $sxcoord - ($wxcoord - $sxcoord)
            $wycoord = $sycoord - ($wycoord - $sycoord)
            $wxcoord = $newwxcoord
        } elseif ($num -eq 270) {
            $newwxcoord = $sxcoord + ($wycoord - $sycoord)
            $wycoord = $sycoord - ($wxcoord - $sxcoord)
            $wxcoord = $newwxcoord
        }
        
    echo "$line    SHIP: $sxcoord $sycoord      WP: $wxcoord $wycoord"
    } elseif ($dir -eq "R") {
    
    echo "$line    SHIP: $sxcoord $sycoord      WP: $wxcoord $wycoord"
        if ($num -eq 90) {
            $newwxcoord = $sxcoord + ($wycoord - $sycoord)
            $wycoord = $sycoord - ($wxcoord - $sxcoord)
            $wxcoord = $newwxcoord
        } elseif ($num -eq 180) {
            $newwxcoord = $sxcoord - ($wxcoord - $sxcoord)
            $wycoord = $sycoord - ($wycoord - $sycoord)
            $wxcoord = $newwxcoord
        } elseif ($num -eq 270) {
            $newwxcoord = $sxcoord - ($wycoord - $sycoord)
            $wycoord = $sycoord + ($wxcoord - $sxcoord)
            $wxcoord = $newwxcoord
        }
        
    echo "$line    SHIP: $sxcoord $sycoord      WP: $wxcoord $wycoord"
    } elseif ($dir -eq "N") {
        $wycoord += $num
    } elseif ($dir -eq "S") {
        $wycoord -= $num
    } elseif ($dir -eq "E") {
        $wxcoord += $num
    } elseif ($dir -eq "W") {
        $wxcoord -= $num
    }

}

$sxcoord = [math]::Abs($sxcoord)
$sycoord = [math]::Abs($sycoord)

echo $($sxcoord + $sycoord)