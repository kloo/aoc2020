<#
#>
<#
Function Print-Array {
    Param (
        [int] $currNum
    )

    Write-Host -NoNewline $currNum
    $nextNum = $initArray[$currNum]
    for ($myiter = 1;$myiter -lt $initArray.Length - 2;$myiter++) {
        Write-Host -NoNewline $nextNum
        $nextNum = $initArray[$nextNum]
    }
}#>

Get-Date

$inputStr = "219347865" # Answer Input String CHANGE THIS
#$inputStr = "389125467" # Test String CHANGE THIS

$iterations = 10000000 #CHANGE THIS 100 for p1, 10000000 for p2
$maxNum = 1000000 # CHANGE THIS

$initArray = [int[]] @(1..($maxNum + 1))
$moveCups = New-Object int[] 3

$strLen = $inputStr.Length

for ($i = 0;$i -lt $strLen;$i++) {
    $currNum = [Convert]::ToInt32($inputStr[$i],10)
    
    if ($i -eq 0) {
        $nextNum = $currNum
    }
    
    if ($i -eq ($strLen - 1)) {
        if ($maxNum -gt $strLen) {
            $insertNum = $strLen + 1
        } else {
            $insertNum = $nextNum
        }
    } else {
        $insertNum = [Convert]::ToInt32($inputStr[$i + 1],10)
    }

    $initArray[$currNum] = $insertNum
}

if ($maxNum -gt $strLen) {
    $initArray[$maxNum] = $nextNum
}

for ($i = 0;$i -lt $iterations;$i++) {
    $currNum = $nextNum

    $moveCups[0] = $initArray[$currNum]
    $moveCups[1] = $initArray[$moveCups[0]]
    $moveCups[2] = $initArray[$moveCups[1]]
    
    $destCup = $currNum - 1
    if ($destCup -eq 0) {
        $destCup = $maxNum
    }
    while ($moveCups.Contains($destCup)) {
        $destCup--
        if ($destCup -eq 0) {
            $destCup = $maxNum
        }
    }

    #Print-Array $currNum
    #Write-Host " : $currNum --- Move: $moveCups --- Dest: $destCup"
    
    
    $nextNum = $initArray[$moveCups[2]]
    $initArray[$currNum] = $nextNum # Remove moving cups

    $endNum = $initArray[$destCup] # Get where end of moving cups should point
    
    $initArray[$destCup] = $moveCups[0] # Insert moving cups
    $initArray[$moveCups[2]] = $endNum # Link end of moving cups back to array
}

$numOne = $initArray[1]
$numTwo = $initArray[$numOne]

$answer = $numOne * $numTwo

echo "$numOne * $numTwo = $answer"
Get-Date