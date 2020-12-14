<#
#>

$strarray = Get-Content in.txt

#[convert]::ToInt64($mask,2)

$memTable = @{}

$mask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
$bandMask = ""
$borMask = ""
#$memTable.Add($key,$value)

foreach ($line in $strarray) {
    if ($line.StartsWith("ma")) {
        $mask = $line.Substring(7)
        $bandMask = [convert]::ToInt64($mask.Replace("X","1"),2)
        $borMask = [convert]::ToInt64($mask.Replace("X","0"),2)
    } elseif ($line.StartsWith("me")) {
        <#
        $line | Select-String -Pattern "^mem`[([0-9]+)`] = ([0-9]+)" |
        Foreach-Object {
            $address, $initVal = $_.Matches[0].Groups[1..2].Value
        } #>

        $address = [convert]::ToInt64(($line.Substring($line.IndexOf("[") + 1, $line.IndexOf("]") - $line.IndexOf("[") - 1)))
        $initVal = [convert]::ToInt64($line.Substring($line.IndexOf("=") + 2))


        $newVal = $initVal -band $bandMask
        $newVal = $newVal -bor $borMask

        if ($memTable.ContainsKey($address)) {
            $memTable[$address] = $newVal
        } else {
            $memTable.Add($address,$newVal)
        }
    }
}

$sum = [convert]::ToInt64(0)
foreach ($key in $memTable.Keys) {
    $sum += $memTable[$key]
}

echo $sum