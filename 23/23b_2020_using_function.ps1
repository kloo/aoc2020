<#

#>

Get-Date

Function Play-Game {
    Param (
        [System.Collections.ArrayList] $cupArray
    )

    $newArray = $cupArray
    
    $moveIndex = $newArray.IndexOf($currCup)

    for ($myiter = 0;$myiter -lt 3;) {
        $moveIndex++
        if ($moveIndex -gt $size) { $moveIndex -= $size }

        $moveCups[$myiter] = $newArray[$moveIndex]
    }

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

    #Write-Host "$newArray : $currNum --- Move: $moveCups --- Dest: $destCup"

    foreach ($moving in $moveCups) {
        $newArray.Remove($moving)
    }
    
    $insertIndex = $newArray.IndexOf($destCup)
    
    foreach ($insertNum in $moveCups) {
        $insertindex++
        $newArray.Insert($insertIndex,$insertNum)
    }

    Write-Output $newArray
}

$inputStr = "219347865" # Answer Input String CHANGE THIS
#$inputStr = "389125467" # Test String CHANGE THIS

$iterations = 10000000 #CHANGE THIS 100 for p1, 10000000 for p2
$maxNum = 1000000 # CHANGE THIS

$initArray = [System.Collections.ArrayList](1..$maxNum)

### Vars to be written to by function ###
$moveCups = New-Object int[] 3

#########################################

for ($i = 0;$i -lt $inputStr.Length;$i++) {
    $initArray[$i] = [Convert]::ToInt32($inputStr[$i],10)
}

$answerArray = $initArray
$size = $answerArray.Count

$nextNum = $answerArray[0]
for ($i = 0;$i -lt $iterations;$i++) {
    $currNum = $nextNum
    $nextIndex = $answerArray.IndexOf($currNum) + 4
    if ($nextIndex -gt $size) {
        $nextIndex -= $size
    }
    $nextNum = $answerArray[$nextIndex]
    $answerArray = Play-Game $answerArray
    
    if ($i -eq 2000) { Get-Date }
}

$answerIndex = $answerArray.IndexOf(1)

$numOne = $answerArray[($answerIndex + 1) % $size]
$numTwo = $answerArray[($answerIndex + 2) % $size]

$answer = $numOne * $numTwo
$answer
