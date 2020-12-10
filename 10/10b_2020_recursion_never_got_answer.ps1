<#
#>

Function Recurse-Values {
    Param (
        [int]$Num,
        [int]$Max
    )

    $answer = 0

    $newArray = @()
    for ($i = 1;$i -le 3;$i++) {
        $CheckNum = $Num + $i
        if ($numarray.Contains($CheckNum) -and ($CheckNum -lt $Max)) {
            $newArray += $CheckNum
        } elseif ($CheckNum -eq $Max) {
            $answer++
        }
    }
    
    foreach ($newNum in $newArray) {
        $answer += [int](Recurse-Values -Num $newNum -Max $Max)
        #$answer += [int]$?
    }

    echo $answer
}

$strarray = Get-Content in.txt

[int[]]$numarray = [int[]]$strarray | Sort-Object

$max = [int]($numarray | Measure -Maximum).Maximum

Recurse-Values -Num 0 -Max $max