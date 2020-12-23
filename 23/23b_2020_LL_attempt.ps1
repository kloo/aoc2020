<#
#>

Get-Date

#$inputStr = "219347865" # Answer Input String CHANGE THIS
$inputStr = "389125467" # Test String CHANGE THIS

$iterations = 10000000 #CHANGE THIS 100 for p1, 10000000 for p2
$maxNum = 1000000 # CHANGE THIS

$initLL = [System.Collections.Generic.LinkedList[int]](1..$maxNum)

$moveCups = New-Object int[] 3

for ($i = $inputStr.Length - 1;$i -ge 0;$i--) {
    $currNum = [Convert]::ToInt32($inputStr[$i],10)
    $initLL.Remove($currNum) | Out-Null
    $initLL.AddFirst($currNum) | Out-Null
}

$nextNode = $initLL.First
for ($i = 0;$i -lt $iterations;$i++) {
    $currNode = $nextNode

    for ($myiter = 0;$myiter -lt 3;$myiter++) {
        $nextNode = $currNode.Next
        if ($nextNode -eq $null) {
            $moveCups[$myiter] = $initLL.First.Value
            $initLL.Remove($initLL.First)
        } else {
            $moveCups[$myiter] = $currNode.Next.Value
            $initLL.Remove($currNode.Next)
        }
    }

    $nextNode = $currNode.Next
    if ($nextNode -eq $null) {
            $nextNode = $initLL.First
    }
    
    $destCup = $currNode.Value - 1
    if ($destCup -eq 0) {
        $destCup = $maxNum
    }
    while ($moveCups.Contains($destCup)) {
        $destCup--
        if ($destCup -eq 0) {
            $destCup = $maxNum
        }
    }

    #Write-Host "$initLL : $($currNode.Value) --- Move: $moveCups --- Dest: $destCup"
    
    $insertNode = $initLL.Find($destCup)
    for ($myiter = 2;$myiter -ge 0;$myiter--) {
        $initLL.AddAfter($insertNode,$moveCups[$myiter]) | Out-Null
    }
    
    if ($i -eq 1000000) { Get-Date }
}


$answerNode = $initLL.Find(1)

$numOne = $answerNode.Next
if ($numOne -eq $null) {
    $numOne = $initLL.First
}
$numTwo = $numOne.Next
if ($numTwo -eq $null) {
    $numTwo = $initLL.First
}
$numOne = $numOne.Value
$numTwo = $numTwo.Value

$answer = $numOne * $numTwo
$answer
