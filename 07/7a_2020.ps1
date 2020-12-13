<#

#>

$strarray = Get-Content in.txt

$continue = $true
$i = 0

$bagArray = @()

$initBags = $strarray | Select-String " shiny gold bag"
foreach ($line in $initBags) {
    $stringCast = [String]$line
    $bagArray += $stringCast.Substring(0,$stringCast.IndexOf(" bags"))
}

echo $bagArray

$i = 0
while ($continue) {
    $currBag = $bagArray[$i]

    $initBags = $strarray | Select-String " $currBag"

    foreach ($line in $initBags) {
        $stringCast = [String]$line

        $newBag = $stringCast.Substring(0,$stringCast.IndexOf(" bags"))
        if (!$bagArray.Contains($newBag)) {
            $bagArray += $newBag
        }
    }

    $i++
    if ($i -eq ($bagArray.Count)) {
        $continue = $false
    }
    echo $bagArray.Count
}
echo $bagArray.Count