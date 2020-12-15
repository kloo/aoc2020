<#
#>

(Get-Date).ToString('T')

$strarray = Get-Content in.txt
$hashTable = @{}

$findNum = 30000000 #Change back to 2020 for answer

$strarray = $strarray.Split(",")

$i = 1
foreach ($num in $strarray) {
    $hashTable.Add($num,@($null,$i))
    $lastNum = $num

    $i++
}

while ($i -le $findNum) {
    if (($hashTable["$lastNum"][0] -ne $null) -and $hashTable.ContainsKey("$lastNum")) {
            $insertNum = $i - ($hashTable["$lastNum"][0]) - 1
    } else { $insertNum = 0 }

    #echo "Finding: $lastNum    Inserting: [$insertNum] = $i   FOR ITERATION: $i"
    
    if ($hashTable.ContainsKey("$insertNum")) {
        $hashTable["$insertNum"] = @($hashTable["$insertNum"][1],$i)
    } else { $hashTable["$insertNum"] = @($null,$i) }
    $lastNum = $insertNum
    $i++

    if ($i.Equals(1000000)) { Write-Host "1 MIL: $((Get-Date).ToString('T'))" }
}

echo $lastNum