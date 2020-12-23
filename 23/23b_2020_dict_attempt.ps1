<#

#>

Get-Date

Function Play-Game {
    Param (
        [int] $searchNum,
        [System.Collections.Specialized.OrderedDictionary] $cupTable
    )

    $newTable = $cupTable

    $keyList = $($newTable.Keys)

    $currCup = $searchNum

    if ( $currCup -lt 10 ) {
        $insertindex = $keylist.IndexOf(([char]"$currCup"))
    } else {
        $insertindex = $keyList.IndexOf($currCup)
    }
    echo $insertIndex

    $moveCups = [ordered]@{
                    [Convert]::ToInt32($keyList[$insertindex + 2],10) = $null
                    [Convert]::ToInt32($keyList[$insertindex + 3],10) = $null
                    [Convert]::ToInt32($keyList[$insertindex + 4],10) = $null
                }

    $destCup = $currCup - 1
    if ($destCup -eq 0) {
        $destCup = $maxNum
    }
    while ($moveCups.Contains($destCup)) {
        $destCup--
        if ($destCup -eq 0) {
            $destCup = $maxNum
        }
    }
    Write-Host "$($newTable.Keys) : $currCup --- Move: $($moveCups.Keys) --- Dest: $destCup"

    foreach ($key in $moveCups.Keys) {
        $newTable.Remove($key)
    }

    $keyList = $($newTable.Keys)
    if ( $destCup -lt 10 ) {
        $insertindex = $keylist.IndexOf(([char]"$destCup"))
    } else {
        $insertindex = $keyList.IndexOf($destCup)
    }
    
    foreach ($insertNum in $moveCups.Keys) {
        $insertindex++
        $newTable.Insert($insertindex,$insertNum,$null)
    }

    Write-Output $newTable
}

#$strarray = Get-Content in.txt
#$inputStr = "219347865" # Answer Input String
$inputStr = "389125467" # Test String

$answerString = $inputStr

$iterations = 10 #100 for p1, 10M for p2
$maxNum = $inputStr.Length

$initTable = [ordered]@{}
$answerTable = [ordered]@{}

for ($i = 0;$i -lt $inputStr.Length;$i++) {
    $initTable.Add([Convert]::ToInt32($inputStr[$i],10),$null)
}

#TODO INSERT EXTRA NUMS

$answerTable = $initTable

$nextNum = [Convert]::ToInt32($inputStr[0],10)
for ($i = 0;$i -lt $iterations;$i++) {
    $currNum = $nextNum

    $keyList = $($answerTable.Keys)

    if ( $currNum -lt 10 ) {
        $nextIndex = $keylist.IndexOf(([char]"$currNum"))
    } else {
        $nextIndex = $keyList.IndexOf($currNum)
    }

    $nextNum = $keylist[$nextIndex + 5]
    $answerTable = Play-Game $currNum -cupTable $answerTable
    
    <#
    if ($i -eq 1000000) { Get-Date }
    #>
}


