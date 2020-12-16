<#
#>

$strarray = Get-Content in.txt

$endValueLine = $strarray.IndexOf("")

$validationsArray = New-Object Object[] $endValueLine

$answer = 0

for ($i = 0; $i -lt $endValueLine;$i++) {
    
    $numberStr = $strarray[$i].Substring($strarray[$i].IndexOf(": ") + 2)

    $delim = $numberStr.IndexOf("-")
    $startNumOne = [int]$numberStr.Substring(0,$delim)

    $numberStr = $numberStr.Substring($delim + 1)
    
    $delim = $numberStr.IndexOf(" ")
    $endNumOne = [int]$numberStr.Substring(0,$delim)

    $numberStr = $numberStr.Substring($delim + 4)
    
    $delim = $numberStr.IndexOf("-")
    $startNumTwo = [int]$numberStr.Substring(0,$delim)

    $numberStr = $numberStr.Substring($delim + 1)
    
    $endNumTwo = [int]$numberStr

    $validationsArray[$i] = @($startNumOne,$endNumOne,$startNumTwo,$endNumTwo)
}

$startTicketLine = $strarray.IndexOf("nearby tickets:") + 1

for ($i = $startTicketLine;$i -lt $strarray.Length;$i++) {
    $ticketValues = $strarray[$i].Split(",")

    for ($j = 0;$j -lt $validationsArray.Count;$j++) {
        $startNumOne = $validationsArray[$j][0]
        $endNumOne = $validationsArray[$j][1]
        $startNumTwo = $validationsArray[$j][2]
        $endNumTwo = $validationsArray[$j][3]

        $currNum = $ticketValues[$j]

        if (!((($currNum -ge $startNumOne) -and ($currNum -le $endNumOne)) -or (($currNum -ge $startNumTwo) -and ($currNum -le $endNumTwo)))) {
            echo "$startNumOne-$endNumOne or $startNumTwo-$endNumTwo     TO: $currNum"
            $answer += $currNum
        }

    }
}

echo $answer