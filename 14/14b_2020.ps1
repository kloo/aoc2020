<#
#>

$strarray = Get-Content in.txt

#[convert]::ToInt64($mask,2)

$memTable = @{}

$mask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
$bitLength = 36
$xCount = 36
#$memTable.Add($key,$value)
$startNum = 0
$countArray = @()

foreach ($line in $strarray) {
    if ($line.StartsWith("ma")) {
        $mask = $line.Substring(7)
        $xCount = $mask.Length - $mask.replace("X","").Length
        $startNum = [Math]::Pow(2,$xCount) - 1

        $countArray = @()
        for ($i = $startNum; $i -ge 0;$i--) {
            [string]$binaryX = [convert]::ToString($i,2)
            while ($binaryX.Length -lt $xCount) {
                $binaryX = "0" + $binaryX
            }

            $countArray += $binaryX
        }
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

        $tempAddress = ""

        for ($i = 0; $i -lt $bitLength;$i++) {
            $currMaskChar = $mask[$i]
            if ($currMaskChar -eq "1") {
                $tempAddress += "1"
            } elseif ($currMaskChar -eq "X") {
                $tempAddress += "X"
            } else {
                $tempAddress += $maskedAddress[$i]
            }
        }

        foreach ($binaryNum in $countArray) {
            $insertAddress = $tempAddress

            for ($i = 0;$i -lt $xCount;$i++) {
                $insertAddress = $insertAddress.Substring(0,$insertAddress.IndexOf("X")) + $binaryNum[$i] + $insertAddress.Substring($insertAddress.IndexOf("X") + 1)
            }

            if ($memTable.ContainsKey($insertAddress)) {
                $memTable[$insertAddress] = $value
            } else {
                $memTable.Add($insertAddress,$value)
            }
        }
    }
}

$sum = [convert]::ToInt64(0)
foreach ($key in $memTable.Keys) {
    $sum += $memTable[$key]
}

echo $sum