<#

#>

Function Play-Game {
    Param (
        [String] $cupString
    )

    $currCup = [int] $cupString.Substring(0,1)
    $nextCup = $cupString.Substring(4,1)

    $moveCups = $cupString.Substring(1,3)

    $destCup = $currCup - 1
    if ($destCup -eq 0) {
            $destCup = $maxNum
    }
    while ($moveCups.IndexOf("$destCup") -ge 0) {
        $destCup--
        if ($destCup -eq 0) {
            $destCup = $maxNum
        }
    }
    Write-Host "$cupString : $currCup --- Move: $moveCups --- Dest: $destCup $($destCup.GetType())"

    #
    $newOrder = "$currCup" + $cupString.Substring(4)
    $destIndex = $newOrder.IndexOf("$destCup") + 1
    $newOrder = $newOrder.Substring(0,$destIndex) + $moveCups + $newOrder.Substring($destIndex)

    $rotateToFrontIndex = $newOrder.IndexOf($nextCup)
    $newOrder = $newOrder.Substring($rotateToFrontIndex) + $newOrder.Substring(0,$rotateToFrontIndex)

    Write-Output $newOrder
}

#$strarray = Get-Content in.txt
#$inputStr = "219347865"
$inputStr = "389125467" # Test String

$answerString = $inputStr

$iterations = 10
$maxNum = $inputStr.Length

#$initTable = [ordered]@{}

<#
for ($i = 0;$i -lt $inputStr.Length;$i++) {
    $initTable.Add($inputStr[$i],$null)
} #>

for ($i = 0;$i -lt $iterations;$i++) {
    $answerString = Play-Game $answerString
}

$answerString

