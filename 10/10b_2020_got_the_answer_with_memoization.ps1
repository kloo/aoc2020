<#
#>

$strarray = Get-Content "in - Copy.txt"

[int[]]$numarray = [int[]]$strarray | Sort-Object

$max = [int]($numarray | Measure -Maximum).Maximum

$countArray = @()
for ($i = 0;$i -le $max;$i++) {
    $countArray += 0
}

$countArray[$max] = 1

for ($i = $max - 1;$i -ge 0;$i--) {
    if ($numarray.Contains($i) -or ($i -eq 0)) {
        for ($j = 1;$j -le 3;$j++) {
            $checkNum = $i + $j
            if ($checkNum -le $max) {
                $countArray[$i] += $countArray[$checkNum]
            }
        }
    }
}

echo $countArray[0]