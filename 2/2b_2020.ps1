<#
Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on.
(Be careful; Toboggan Corporate Policies have no concept of "index zero"!) Exactly one of these positions must contain the given letter.
Other occurrences of the letter are irrelevant for the purposes of policy enforcement.

Given the same example list from above:

1-3 a: abcde is valid: position 1 contains a and position 3 does not.
1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.
#>

$strarray = Get-Content 2a.txt
$validCount = 0

$regex = "^(\d+)-(\d+)\s+(\w):\s+(\w+)"


$strarray | Select-String -Pattern "^(\d+)-(\d+)\s+(\w):\s+(\w+)" | ForEach-Object {
    $firstPos = $_.Matches[0].Groups[1].Value - 1
    $secondPos = $_.Matches[0].Groups[2].Value - 1
    $letterBound = $_.Matches[0].Groups[3].Value
    $password = $_.Matches[0].Groups[4].Value

    Write-Host -NoNewline "$_ "

    if (($password[$firstPos] -eq "$letterBound") -xor ($password[$secondPos] -eq "$letterBound")) {
        $validCount++
        Write-Host "good"
    } else { Write-Host "bad" }
}

echo "Valid Count: $validCount"