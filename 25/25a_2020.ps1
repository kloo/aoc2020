<#

#>

$strarray = Get-Content in.txt

$modinput = 20201227
$value = 1

$subject = 7

$cardKey = [Convert]::ToInt64($strarray[0],10)
$doorKey = [Convert]::ToInt64($strarray[1],10)

#Commenting out as got values below with this block of code

$cardIter = 0
while ($value -ne $cardKey) {
    $value = ($value * $subject) % 20201227
    $cardIter++
}

$value = 1
$doorIter = 0
while ($value -ne $doorKey) {
    $value = ($value * $subject) % 20201227
    $doorIter++
}

echo "Card Loops: $cardIter"
echo "Door Loops: $doorIter"


#$cardIter = 13467729
#$doorIter = 3020524

if ($cardIter -gt $doorIter) {
    $subject = $cardKey
    $loopIter = $doorIter
} else {
    $subject = $doorKey
    $loopIter = $cardIter
}

# Example Input
#$subject = 5764801
#$loopIter = 11

#$subject = 17807724
#$loopIter = 8

$value = 1
for ($i = 0;$i -lt $loopIter;$i++) {
    $value = ($value * $subject) % $modinput
}

echo "Asnwer: $value" #Not 1542889, 8364119, 7022834, had some cached values in shell from previous runs