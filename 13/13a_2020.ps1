<#

#>

$strarray = Get-Content in.txt

$searchTime = [int]($strarray[0])
$rawBusList = $strarray[1].Split(",")
$runningBusList = @()

$mybus = 0

foreach ($bus in $rawBusList) {
    if ($bus -ne "x") {
        $runningBusList += [int]$bus
    }
}

$min = [int]::MaxValue

foreach ($bus in $runningBusList) {
    $num = $bus

    while ($num -lt $searchTime) {
        $num += $bus
    }
    

    if ($num -lt $min) {
        $min = $num
        $mybus = $bus
    }
}

$answer = $mybus * ($min - $searchTime)

echo $answer