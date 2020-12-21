<#
    -match validation on the regex was using capturing groups.
    Post submission improvement of runtime from ~1 second to 
        Changing capturing groups to non-capturing groups
#>

Function Evaluate-String {
    Param (
        [string]$inputStr
    )

    $myVals = $inputStr.Split(" ")

    for ($j = 0; $j -lt $myVals.Count;$j++) {
        $currValue = $myVals[$j]
        #Write-Host $currValue
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

$strarray = Get-Content in_part_2.txt

$endLine = $strarray.Count
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
$zeroVals = $zeroVals.Replace("(+)","+")

$zeroVals = $zeroVals.Replace("(()","(")
$zeroVals = $zeroVals.Replace("())",")")

$zeroVals = $zeroVals.Replace("(","(?:")
#echo $zeroVals

#$MatchesGroupCounts = New-Object int[] ($endLine - $breakIndex - 1)

$matchString = '^' + $zeroVals + '$'
for ($i = $breakIndex + 1;$i -lt $endLine;$i++) {
    if ($strarray[$i] -match $matchString) {
        $currValidStrings++
    }

    #$MatchesGroupCounts[$endLine - $i - 1] = $Matches.Keys.Count
}

<#
$myCounts = $MatchesGroupCounts | sort
$myCounts[0]
$myCounts[$myCounts.Count - 1]
#>

$currValidStrings