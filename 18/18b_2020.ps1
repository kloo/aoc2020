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


    $answer = $evalString.Split(" ")

    $currLength = $answer.Count
    while ($currLength -gt 1) {
        $myEvalIndex = $answer.IndexOf("+")
        if ($myEvalIndex -ge 0) {
            $myEvalIndex = $answer.IndexOf("+")

            $myPart = [convert]::ToInt64($answer[$myEvalIndex - 1],10) + [convert]::ToInt64($answer[$myEvalIndex + 1],10)
            
            if ($myEvalIndex -eq 1) { # Add to front
                $answer = @($myPart) + $answer[($myEvalIndex + 2)..($currLength)]
            } elseif ($myEvalIndex -ge ($currLength - 2)) { # Add to End
                $answer = $answer[0..($myEvalIndex - 2)] + @($myPart)
            } else { # Add somewhere in the middle
                $answer = $answer[0..($myEvalIndex - 2)] + @($myPart) + $answer[($myEvalIndex + 2)..($currLength)]
            }
        } else {
            $myEvalIndex = $answer.IndexOf("*")

            $myPart = [convert]::ToInt64($answer[$myEvalIndex - 1],10) * [convert]::ToInt64($answer[$myEvalIndex + 1],10)
            
            if ($myEvalIndex -eq 1) { # Add to front
                $answer = @($myPart) + $answer[($myEvalIndex + 2)..($currLength)]
            } elseif ($myEvalIndex -ge ($currLength - 2)) { # Add to End
                $answer = $answer[0..($myEvalIndex - 2)] + @($myPart)
            } else { # Add somewhere in the middle
                $answer = $answer[0..($myEvalIndex - 2)] + @($myPart) + $answer[($myEvalIndex + 2)..($currLength)]
            }
        }

        $currLength = $answer.Count
    }

    echo $answer[0]
}

$strarray = Get-Content in.txt

$myval = 0

foreach ($line in $strarray) {
    $myval += Evaluate-String "$line"
}

echo "Final: $myval"