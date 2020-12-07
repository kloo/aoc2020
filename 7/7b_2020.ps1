<#
#>

$strarray = Get-Content in.txt

$continue = $true
$i = 0

$bagArray = @()

$count = 0
$initBags = $strarray | Select-String "shiny gold bags contain"
#shiny gold bags contain 1 dull lime bag, 2 pale coral bags, 1 wavy silver bag, 5 muted black bags.
$clip = ([String]$initBags).IndexOf("contain") + 8
$initBags = ([String]$initBags).Substring($clip).Split(",")

for ($i = 0;$i -lt $initBags.Count;$i++) {
    if (!$initBags[$i].Contains("no other")) {
        if ($initBags[$i].IndexOf(" ") -eq 0) {
            $initBags[$i] = $initBags[$i].Substring(1)
        }

        $bagArray += $initBags[$i]

        $count += $initBags[$i].Substring(0,$initBags[$i].IndexOf(" "))
    }
}

$inc = 0
while ($continue) {
    $currBag = $bagArray[$inc]

    Write-Host -NoNewline "$($currBag.Substring(2)) $inc"

    $currBagMultiplier = [int]$currBag.Substring(0,$currBag.IndexOf(" "))
    
    $currBagColor = $currBag.Substring($currBag.IndexOf(" ") + 1)
    $currBagColor = $currBagColor.Substring(0,$currBagColor.IndexOf(" bag"))

    $initBags = $strarray | Select-String "$currBagColor bags contain"
    $clip = ([String]$initBags).IndexOf("contain") + 8
    $initBags = ([String]$initBags).Substring($clip).Split(",")

    for ($i = 0;$i -lt $initBags.Count;$i++) {
        if (!$initBags[$i].Contains("no other")) {
            if ($initBags[$i].IndexOf(" ") -eq 0) {
                $initBags[$i] = $initBags[$i].Substring(1)
            }
            
            $mybag = $initBags[$i]
            $bagArray += "$($currBagMultiplier * [int](([String]$mybag).Substring(0,$mybag.IndexOf(" "))))$($mybag.SubString($mybag.IndexOf(`" `")))"

            $count += $currBagMultiplier * $initBags[$i].Substring(0,$initBags[$i].IndexOf(" "))
        }
    }

    $inc++
    if ($inc -eq ($bagArray.Count)) {
        $continue = $false
    }
}
echo ""
echo $count