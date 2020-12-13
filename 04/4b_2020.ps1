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

                if ($data[0] -eq "byr") {
                    if ($data[1] -match '^[0-9]{4}$') {
                        if (([int]$data[1] -ge 1920) -and ([int]$data[1] -le 2002)) {
                            $found[$validFields.IndexOf($data[0])]++
                        }
                    }
                } elseif ($data[0] -eq "iyr") {
                    if ($data[1] -match '^[0-9]{4}$') {
                        if (([int]$data[1] -ge 2010) -and ([int]$data[1] -le 2020)) {
                            $found[$validFields.IndexOf($data[0])]++
                        }
                    }
                } elseif ($data[0] -eq "eyr") {
                    if ($data[1] -match '^[0-9]{4}$') {
                        if (([int]$data[1] -ge 2020) -and ([int]$data[1] -le 2030)) {
                            $found[$validFields.IndexOf($data[0])]++
                        }
                    }
                } elseif ($data[0] -eq "hgt") {
                    if ($data[1] -match '^[0-9]+[c-n]{2}$') {
                        if ($data[1].Contains("cm")) {
                            if (([int]$data[1].Substring(0,$data[1].Length - 2) -ge 150) -and ([int]$data[1].Substring(0,$data[1].Length - 2) -le 193)) {
                                $found[$validFields.IndexOf($data[0])]++
                            }
                        } elseif ($data[1].Contains("in")) {
                            if (([int]$data[1].Substring(0,$data[1].Length - 2) -ge 59) -and ([int]$data[1].Substring(0,$data[1].Length - 2) -le 76)) {
                                $found[$validFields.IndexOf($data[0])]++
                            }
                        }
                    }
                } elseif ($data[0] -eq "hcl") {
                    if ($data[1] -match '#[0-9a-f]{6}') {
                        $found[$validFields.IndexOf($data[0])]++
                    }
                } elseif ($data[0] -eq "ecl") {
                    if ($validColor.Contains($data[1])) {
                        $found[$validFields.IndexOf($data[0])]++
                    }
                } elseif ($data[0] -eq "pid") {
                    if ($data[1] -match '^[0-9]{9}$') {
                        $found[$validFields.IndexOf($data[0])]++
                    }
                }
            }
        }
    }
}

echo "$validCount Max: 291"