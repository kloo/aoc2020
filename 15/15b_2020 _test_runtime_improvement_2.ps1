<#
    Improved cold runtime from ~3.5 to ~0.7 minutes by
        changing hash table with 2 length array values to two large arrays
#>
$strarray = Get-Content in.txt
$hashTable = @{}

$findNum = 30000000

$strarray = $strarray.Split(",")

$lastCall = New-Object int[] $findNum
$secondToLastCall = New-Object int[] $findNum

$i = 1
foreach ($num in $strarray) {
    $lastTime = $lastCall[$num]

    if ($lastTime -ne 0) { $secondToLastCall[$num] = $lastTime }
    $lastCall[$num] = $i

    $lastNum = $num
    $i++
}

while ($i -le $findNum) {
    $lastTime = $lastCall[$lastNum]
    $secondToLastTime = $secondToLastCall[$lastNum]

    if ($secondToLastTime -ne 0) {
            $insertNum = $i - $secondToLastTime - 1
    } else { $insertNum = 0 }
    
    $lastTime = $lastCall[$insertNum]
    if ($lastTime -ne 0) { $secondToLastCall[$insertNum] = $lastTime }
    $lastCall[$insertNum] = $i

    $lastNum = $insertNum
    $i++
}

echo $insertNum
