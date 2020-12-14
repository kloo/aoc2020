<#
#>

$strarray = Get-Content in.txt

#[convert]::ToInt64($mask,2)

$memTable = @{}

$mask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
$bitLength = 36
$xCount = 36
#$memTable.Add($key,$value)

foreach ($line in $strarray) {
    if ($line.StartsWith("ma")) {
        $mask = $line.Substring(7)
        $xCount = $mask.Length - $mask.replace("X","").Length
    } elseif ($line.StartsWith("me")) {
        $initAddress = [convert]::ToInt64(($line.Substring($line.IndexOf("[") + 1, $line.IndexOf("]") - $line.IndexOf("[") - 1)))
        $value = [convert]::ToInt64($line.Substring($line.IndexOf("=") + 2))

        [string]$maskedAddress = [convert]::ToString($initAddress,2)
        $padding = ""
        if ($maskedAddress.Length -lt 36) {
            for($i = 0; $i -lt ($bitLength - $maskedAddress.Length);$i++) {
                $padding += "0"
            }
        }
        $maskedAddress = $padding + $maskedAddress

        $newAddress = ""

        for ($i = 0; $i -lt $bitLength;$i++) {
            $currMaskChar = $maskedAddress[$i]
            if ($currMaskChar -eq "1") {
                $newAddress += "1"
            } elseif ($currMaskChar -eq "0") {
                $newAddress += $initAddress[$i]
            } else {
                $newAddress += "X"
            }
        }



        <#
        if ($memTable.ContainsKey($address)) {
            $memTable[$address] = $newVal
        } else {
            $memTable.Add($address,$newVal)
        }#>
    }
}

$sum = [convert]::ToInt64(0)
foreach ($key in $memTable.Keys) {
    $sum += $memTable[$key]
}

echo $sum