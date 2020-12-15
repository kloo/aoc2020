<#
#>

$strarray = Get-Content in.txt
$hashTable = @{}

$findNum = 10 #Change back to 2020 for answer

$myCount = New-Object int[] $findNum

$strarray = $strarray.Split(",")

for ($i = $findNum - 1; $i -ge ($findNum - $strarray.Count);$i--) {
    $myCount[$i] = $strarray[$findNum - ($i+1)]
}

$insertNum = 0
while ($i -gt 0) {
    $searchArray = $myCount[($i + 1)..$findNum]
    if ($searchArray.Contains($myCount[$i])) {
            $insertNum = $searchArray.IndexOf($myCount[$i]) + 1
    } else { $insertNum = 0 }
    
    if ($i % 1000000 -eq 0) {
        echo $i
    }

    $i--
    $myCount[$i] = $insertNum
}

echo $myCount[0]