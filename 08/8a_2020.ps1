<#

#>

$strarray = Get-Content in.txt

$commandList = @()

$commandNum = 0
$accumulator = 0

$noDupes = $true
while ($noDupes) {
    if ($commandList.Contains($commandNum)) {
        $noDupes = $false
    } else {
        $currCommand = $strarray[$commandNum]
        $commArray = $currCommand.Split(" ")

        echo $currCommand

        $commandList += $commandNum

        if ($commArray -eq "acc") {
            $accumulator += [int]($commArray[1])
            $commandNum++
        } elseif ($commArray -eq "jmp") {
            $commandNum += [int]$commArray[1]
        } elseif ($commArray -eq "nop") {
            $commandNum++
        }
    }
}

echo $accumulator