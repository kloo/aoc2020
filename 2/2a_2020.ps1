<#
Suppose you have the following list:

1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc

Each line gives the password policy and then the password.
The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid.
For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.
#>

$strarray = Get-Content 2a.txt
$validCount = 0

$regex = "^(\d+)-(\d+)\s+(\w):\s+(\w+)"


$strarray | Select-String -Pattern "^(\d+)-(\d+)\s+(\w):\s+(\w+)" | ForEach-Object {
    $lowerBound = $_.Matches[0].Groups[1].Value
    $upperBound = $_.Matches[0].Groups[2].Value
    $letterBound = $_.Matches[0].Groups[3].Value
    $password = $_.Matches[0].Groups[4].Value

    $charCount = ($password.ToCharArray() | Where-Object {$_ -eq "$letterBound"} | Measure-Object).Count
    Write-Host -NoNewline "$_, $charCount, $lowerBound $upperBound $letterBound $password"

    if (($charCount -ge $lowerBound) -and ($charCount -le $upperBound)) {
        $validCount++
        Write-Host "good"
    } else { Write-Host "bad" }
}

echo "Valid Count: $validCount"