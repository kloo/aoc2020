<#
#>

$strarray = Get-Content in.txt

$totalCount = 0

$validCount = @()
for ($i = 0; $i -lt 26;$i++) { $validCount += 0 }

#$storedZeroArray = $validCount #This is not a deep copy

foreach ($line in $strarray) {

    if ($line -eq "") {
        foreach ($entry in $validCount) {
            if ($entry -gt 0) {
                $totalCount++
            }
        }

        $validCount = @()
        for ($i = 0; $i -lt 26;$i++) { $validCount += 0 }

    } else {
        $charArray = [char[]]$line
        foreach ($character in $charArray) {
            $validCount[[char]"$character" - [char]"a"]++
        }
    }
}

Write-Output "TOTAL: $totalCount"