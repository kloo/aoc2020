<#
#>

$strarray = Get-Content in.txt

$preambleCount = 25

$validArray = $strarray[0..$($preambleCount - 1)]


#$a, $b = $validArray + $strarray[26]
for ($i = $preambleCount;$i -lt $strarray.Count;$i++) {
    $foundMatch = $false
    $currValidation = $strarray[$i]


    for ($j = 0;$j -lt $preambleCount;$j++) {
        $currNum = $validArray[$j]
        $findNum = $currValidation - $currNum
        if (($findNum -lt $currValidation) -and $validArray.Contains($findNum)) {
            $foundMatch = $true
        }
    }

    $trash, $validArray = $validArray + $strarray[$i]

    if (!$foundMatch) {
        echo $strarray[$i]
        break
    }
}