<#

#>

$strarray = Get-Content in.txt

$commandList = @()

$commandNum = 0
$accumulator = 0

$jumpCount = 0
$jumpSkip = 0

$noDupes = $true
while ($noDupes) {
    if ($commandList.Contains($commandNum)) {
        $commandNum = 0
        $commandList = @()

        $commandNum = 0
        $accumulator = 0

        $jumpCount = 0
        $jumpSkip++
    } elseif (($commandNum -ge $strarray.Count)) {
        $noDupes = $false
    } else {
        $currCommand = $strarray[$commandNum]
        $commArray = $currCommand.Split(" ")

        if ($commArray[0] -eq "jmp") {
        echo "$currCommand $commandNum" }

        $commandList += $commandNum

        if ($commArray[0] -eq "acc") {
            $accumulator += [int]($commArray[1])
            $commandNum++
        } elseif ($commArray[0] -eq "jmp") {
            if ($jumpCount = $jumpSkip) {
                $commandNum++
            } else {
                $commandNum += [int]$commArray[1]
            }
            $jumpCount++
        } elseif ($commArray[0] -eq "nop") {
            $commandNum++
        }

        
    }
}

echo "$commandNum vs 638"
echo $accumulator