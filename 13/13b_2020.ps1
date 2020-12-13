<#
Had to look up hint for Chinese Remainder Theorem
#>

$strarray = Get-Content in.txt

$searchTime = [int]($strarray[0])
$rawBusList = $strarray[1].Split(",")
$runningBusList = @()
$remainderCount = @()

$answerToSum = @()
$totalProduct = 1

for ($i = 0;$i -lt $rawBusList.Count;$i++) {
    if ($rawBusList[$i] -ne "x") {
        $runningBusList += $rawBusList[$i]
        $remainderCount += ($rawBusList[$i] - $i) #% $rawBusList[$i]
        $totalProduct *= $rawBusList[$i]
    }
}

for ($i = 0;$i -lt $runningBusList.Count;$i++) {
    <#
    $j = 1

    $mybus = $runningBusList[$i]
    $myremainder = $remainderCount[$i]

    $partialSum = $totalProduct % $mybus
    while ((($partialSum * $j) % $mybus) -ne $myremainder) {
        $j++
        Write-Host -NoNewline "$j "
    }

    $answerToSum += ($partialSum * $j)
    Write-Host ""
    Write-Host "$answerToSum"
    #>

    Write-Output "$($remainderCount[$i]) mod $($runningBusList[$i])"

    # Figuring out what to plug into existing calculator
    # 1891577883 (mod 2331549337)
    # 672754147786752
    # 93826541391137737
    # 75909940829805303
    # 92425732560172115
    # ANSWER: 672754131923874

    <#
    x = 0 mod 13
    x = 38 mod 41 
    x = 454 mod 467 
    x = 13 mod 19 
    x = 4 mod 17 
    x = 16 mod 29 
    x = 309 mod 353 
    x = 24 mod 37
    x = 2 mod 23
    #>
}
<#
$sum = 0
foreach ($num in $answerToSum) {
    Write-Host -NoNewline "$num + "
    $sum += $num
}
echo ""
echo $sum
#>

<#
1068781

x = 0 % 7
x = 12 % 13
x = 55 % 59
x = 25 % 31
x = 12 % 19
#>