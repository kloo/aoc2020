$strarray = Get-Content in_b.txt

$outfile = "trimmed_b.txt"

$nodeSize = 10
$grabLength = $nodeSize - 2

$fileLength = $strarray.Count

$newarray = New-Object Object[] (($fileLength / $nodeSize) * $grabLength)

$currLength = 0

for ($i = 0;$i -lt $fileLength;$i++) {
    $skipRow = $i % $nodeSize

    if (!(($skipRow -eq 0) -or ($skipRow -eq ($nodeSize - 1)))) {
        $currRow = $strarray[$i]

        $currString = ""

        for ($j = 1;$j -lt $fileLength;$j += $nodeSize) {
            $currString += $currRow.Substring($j,$grabLength)
        }
        
        $newarray[$currLength] = $currString
        $currLength++
    }
}

Write-Output $newarray > $outfile