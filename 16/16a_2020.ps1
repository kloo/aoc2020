<#
#>

$strarray = Get-Content in.txt

$endValueLine = $strarray.IndexOf("")

$validationsTable = @{}

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

    for($j = $startNumOne;$j -le $endNumOne;$j++) {
        if (!$validationsTable.ContainsKey($j)) {
            $validationsTable.Add($j,$null)
        }
    }

    for($j = $startNumTwo;$j -le $endNumTwo;$j++) {
        if (!$validationsTable.ContainsKey($j)) {
            $validationsTable.Add($j,$null)
        }
    }
}

$startTicketLine = $strarray.IndexOf("nearby tickets:") + 1

for ($i = $startTicketLine;$i -lt $strarray.Length;$i++) {
    $ticketValues = $strarray[$i].Split(",")

    $changed = $false

    for ($j = 0;$j -lt $ticketValues.Count;$j++) {
        $currNum = [int]$ticketValues[$j]

        if (!$validationsTable.ContainsKey($currNum)) {
            $answer += $currNum
            $changed = $true
        }
    }

    if (!$changed) {
        echo $strarray[$i]
    }
}

echo $answer