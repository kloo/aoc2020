<#
    Improved runtime from ~8 to ~3.5 minutes by
        removing debug line
        adding line 20 value caching
        removed redundant exists check on line 21
#>
$strarray = Get-Content in.txt
$hashTable = @{}

$findNum = 30000000 #Change back to 2020 for answer

$strarray = $strarray.Split(",")

$i = 1
foreach ($num in $strarray) {
    $hashTable.Add($num,@($null,$i))
    $lastNum = "$num"

    $i++
}

while ($i -le $findNum) {
    if (($prevVal = $hashTable[$lastNum][0]) -ne $null) {
            $insertNum = $i - $prevVal - 1
    } else { $insertNum = 0 }
    
    if ($hashTable.ContainsKey("$insertNum")) {
        $hashTable["$insertNum"] = @($hashTable["$insertNum"][1],$i)
    } else { $hashTable["$insertNum"] = @($null,$i) }
    $lastNum = "$insertNum"
    $i++
}

echo $lastNum
