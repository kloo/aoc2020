<#

#>

Function Evaluate-String {
    Param (
        [string]$mystr
    )

    #Write-Host $mystr
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

    #Write-Host $evalString


    $evalString = $evalString.Split(" ")
    $answer = [convert]::ToInt32($evalString[0],10)

    foreach ($item in $evalString) {
        if ($item -eq "+") { # 0: add, 1: mult
            $mode = 0
        } elseif ($item -eq "*") {
            $mode = 1
        } elseif ($item -match "[0-9]+") {
            if ($mode -eq 0) {
                $answer += [convert]::ToInt32($item,10)
            } elseif ($mode -eq 1) {
                $answer *= [convert]::ToInt32($item,10)
            }
        }
    }

    echo $answer
}

$strarray = Get-Content in.txt

$myval = 0

foreach ($line in $strarray) {
    $myval += Evaluate-String "$line"
}

echo "Final: $myval"