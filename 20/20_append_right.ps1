$strarray = Get-Content rotThis.txt

$size = $strarray.Count

$rotArr = New-Object 'Object[,]' $size,$size

echo "ORIG:"
echo $currGrid

echo ""
echo "ROTATE RIGHT:"

for ($i = 0; $i -lt $size; ++$i) {
    for ($j = 0; $j -lt $size; ++$j) {
        $rotArr[$i,$j] = $currGrid[$size - $j - 1][$i];

        Write-Host -NoNewline $rotArr[$i,$j]
    }
    Write-Host
}

echo ""
echo "ROTATE LEFT:"

for ($i = 0; $i -lt $size; ++$i) {
    for ($j = 0; $j -lt $size; ++$j) {
        $rotArr[$i,$j] = $currGrid[$j][$size - $i - 1];

        Write-Host -NoNewline $rotArr[$i,$j]
    }
    Write-Host
}

echo ""
echo "FLIP VERTICAL:"
for ($i = $size - 1;$i -ge 0;$i--) {
    Write-Host $currGrid[$i]
}

echo ""
echo "FLIP HORIZONTAL"

for ($i = 0; $i -lt $size; $i++) {
    $revString = $currGrid[$i].ToCharArray()
    [array]::Reverse($revString)
    $revString = -join($revString)
    Write-Host $revString
}