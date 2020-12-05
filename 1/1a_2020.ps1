# find the two entries that sum to 2020 and then multiply those two numbers together.

$strarray = Get-Content 1a.txt
$strarray = $strarray | Sort-Object { [int]$_ }

# Convert String array to int for math operations
$numarray = @()
foreach ($line in $strarray) {
    $numarray += [int]$line
}

$searchStart = 0
$end = $numarray.Count - 1
$found = $False
$searchEnd = $end

while (!$found) {
    $sum = $numarray[$searchStart] + $numarray[$searchEnd]
    while ($sum -gt 2020) {
        $searchEnd--
        $sum = $numarray[$searchStart] + $numarray[$searchEnd]
    }

    if ($sum -eq 2020) {
        $found = $True
    } else {
        $searchStart++
        $searchEnd = $end
    }
}

echo "------------------------"
echo "$($numarray[$searchStart]) + $($numarray[$searchEnd]) = " $($numarray[$searchStart] + $numarray[$searchEnd])
echo "------------------------"
echo "The answer is: $($numarray[$searchStart] * $numarray[$searchEnd])"