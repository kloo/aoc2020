<#
#>

$strarray = Get-Content in.txt

$myNum = 776203571
$start = 0
$end = 1

#$a, $b = $validArray + $strarray[26]
for ($i = 0;$i -lt $strarray.Count;$i++) {
    $foundMatch = $false
    $runningCount = [int]$strarray[$i]

    for ($j = $i + 1;$j -lt $strarray.Count;$j++) {
        $runningCount += [int]$strarray[$j]

        if ($runningCount -gt $myNum) {
            break
        } elseif ($runningCount -eq $myNum) {
            $start = $i
            $end = $j
            $foundMatch = $true
        }
    }

    if ($foundMatch) {
        break
    }
}

$myarray = $strarray[$start..$end]
$min = [int]($myarray | Measure -Minimum).Minimum
$max = [int]($myarray | Measure -Maximum).Maximum

echo $($min + $max)