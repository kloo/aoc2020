#Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.

# find the three entries that sum to 2020 and then multiply those numbers together.

$strarray = Get-Content 1a.txt
$strarray = $strarray | Sort-Object { [int]$_ }

# Convert String array to int for math operations
$numarray = @()
foreach ($line in $strarray) {
    $numarray += [int]$line
}

$numOneIndex = 0
$numOne = $numarray[$numOneIndex]
$numTwoIndex = $numOneIndex + 1
$numTwo = $numarray[$numTwoIndex]
$highestNum = $numarray[$numarray.Count - 1]
$found = $False

$sum = $numarray[$numOneIndex] + $numarray[$numTwoIndex]
$numThree = 2020 - $sum


while (!$found) {
    while ($numThree -gt $numTwo) {
        if ($($numarray.Contains($numThree))) {
            $found = $True
            break
        } else {
            echo "$numOneIndex, $numTwoIndex, $sum, $numThree, $($numarray.Contains($numThree))"
            $numTwoIndex++
            $numTwo = $numarray[$numTwoIndex]
            $sum = $numOne + $numarray[$numTwoIndex]
            $numThree = 2020 - $sum
        }
    }

    if (!$found) {
        $numOneIndex++
        $numOne = $numarray[$numOneIndex]
        $numTwoIndex = $numOneIndex + 1
        $numTwo = $numarray[$numTwoIndex]
    }
}

echo "------------------------"
echo "$numOne + $numTwo + $numThree= " $($numOne + $numarray[$numTwoIndex] + $numThree)
echo "------------------------"
echo "The answer is: $($numOne * $numarray[$numTwoIndex] * $numThree)"