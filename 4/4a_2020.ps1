<#

#>

$strarray = Get-Content in.txt

$validFields = @("byr","iyr","eyr","hgt","hcl","ecl","pid")
$found = @(0,0,0,0,0,0,0)

$validColor = @("amb","blu","brn","gry","grn","hzl","oth")

$totalCount = 0
$validCount = 0

foreach ($line in $strarray) {
    if ($line -eq "") {
        
        $sum = 0
        Foreach ($valid in $found) {
            if ($valid -eq 1) { $sum++ }
        }

        if ($sum -eq 7) {
            $validCount++
        }
        

        echo "$validFields"
        echo "$found"
        echo "$sum, $validCount"
        $found = @(0,0,0,0,0,0,0)
    } else {
        $fields = $line.Split(" ")

        foreach ($entry in $fields) {
            $data = $entry.Split(":")
            if ($validFields.Contains($data[0])) {
                $found[$validFields.IndexOf($data[0])]++
            }
        }
    }
}

echo "$validCount Max: 291"