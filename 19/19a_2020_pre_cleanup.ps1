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

Function Parse-Parens {
    Param (
        [string]$inputStr
    )

    $evalString = $mystr

    $parenIndex = $evalString.IndexOf("(")

    while ($parenIndex -ge 0) {
        $parenEnd = 1

        for ($endIndex = $parenIndex + 1;$parenEnd -gt 0;$endIndex++) {
            $currChar = $evalString[$endIndex]

            if ($currChar -eq "(") {
                $parenEnd++
            } elseif ($currChar -eq ")") {
                $parenEnd--
            }
        }

        $evalString = $evalString.Substring(0,$parenIndex) + $(Evaluate-String $evalString.Substring($parenIndex + 1, $endIndex - ($parenIndex + 2))) + $evalString.Substring($endIndex)

        $parenIndex = $evalString.IndexOf("(")
    }
}

$strarray = Get-Content in.txt

$breakIndex = $strarray.IndexOf("")

$ruleArray = New-Object String[] $breakIndex

#$inputStringArr = New-Object String[] ($strarray.Count - ($breakIndex + 1))

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

<#
# Read in input strings to validate
for ($i = $breakIndex + 1;$i -lt $strarray.Count;$i++) {
    $currInputLine = $strarray[$i]


    $inputStringArr[$i] = $currInputLine
}#>


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