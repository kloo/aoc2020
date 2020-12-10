<#
#>

$strarray = Get-Content in.txt

[int[]]$numarray = [int[]]$strarray | Sort-Object

$oneJolt = 1
$threeJolt = 1

for ($i = 0;$i -lt ($numarray.Count - 1);$i++) {
    $currNum = $numarray[$i]
    $nextNum = $numarray[$i + 1]

    $diff = $nextNum - $currNum

    if ($diff -eq 1) { $oneJolt++ }
    elseif ($diff -eq 3) { $threeJolt++ }
}

$answer = $oneJolt * $threeJolt
echo $answer