<#
#>

$strarray = Get-Content purged_in.txt

$endValueLine = $strarray.IndexOf("")

$minMaxArr = New-Object int[] ($endValueLine*2)

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


for ($k = 0;$k -lt 20;$k++) {
    $myValidArray = New-Object int[] $validationsArray.Count

    for ($i = $startTicketLine;$i -lt $strarray.Length;$i++) {
        $fieldValue = [int]$strarray[$i].Split(",")[$k]

        for ($j = 0;$j -lt $validationsArray.Count;$j++) {
            $startNumOne = $validationsArray[$j][0]
            $endNumOne = $validationsArray[$j][1]
            $startNumTwo = $validationsArray[$j][2]
            $endNumTwo = $validationsArray[$j][3]

            if (!((($fieldValue -ge $startNumOne) -and ($fieldValue -le $endNumOne)) -or (($fieldValue -ge $startNumTwo) -and ($fieldValue -le $endNumTwo)))) {
                $myValidArray[$j] = 1
            }
        }
    }

    echo "$k : $myValidArray"
}