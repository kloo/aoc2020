<#

#>

Function Evaluate-String {
    Param (
        [string]$inputStr
    )

    $myVals = $inputStr.Split(" ")

    for ($j = 0; $j -lt $myVals.Count;$j++) {
        $currValue = $myVals[$j]
        if ($currValue -match "[0-9]+") {
            $myVals[$j] = Evaluate-String $ruleArray[$currValue]
        }
    }

    $myStr = ""
    if ($myVals.Count -eq 1) {
        $myStr = $myVals[0]
    } else {
        foreach ($value in $myVals) {
            $myStr += "($value)"
        }
    }

    Write-Output $myStr
}

$strarray = Get-Content in.txt

$breakIndex = $strarray.IndexOf("")

$ruleArray = New-Object String[] $breakIndex

$currValidStrings = 0

# Read in rules
for ($i = 0;$i -lt $breakIndex;$i++) {
    $currRuleLine = $strarray[$i]

    $ruleNum = [convert]::ToInt32($currRuleLine.Substring(0,$currRuleLine.IndexOf(":")))

    $ruleString = $currRuleLine.Substring($currRuleLine.IndexOf(":") + 2)

    if ($ruleString.IndexOf("`"") -ge 0) {
        $ruleString = $ruleString.Substring($ruleString.IndexOf("`"") + 1, 1)
    }

    $ruleArray[$ruleNum] = $ruleString
}

# Validate for rule 0

$zeroVals = Evaluate-String $ruleArray[0]

$zeroVals = $zeroVals.Replace("(a)","a")
$zeroVals = $zeroVals.Replace("(b)","b")
$zeroVals = $zeroVals.Replace("(|)","|")
#echo $zeroVals

$matchString = '^' + $zeroVals + '$'
for ($i = $breakIndex + 1;$i -lt $strarray.Count;$i++) {
    if ($strarray[$i] -match $matchString) {
        $currValidStrings++
    }
}

$currValidStrings