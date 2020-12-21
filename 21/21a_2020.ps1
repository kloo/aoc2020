<#

2103 too high
2070 too low
2075
#>

$strarray = Get-Content in.txt

$alienIngredients = @{}
$engIngredients = @{}

$safeHash = @{}

foreach ($line in $strarray) {
    $tempArr = $line.Split("(")
    $alienList = $tempArr[0].Substring(0,$tempArr[0].Length-1).Split(" ")
    $engList = $tempArr[1].Substring(9)
    $engList = $engList.Substring(0,$engList.Length - 1).Split(",")

    foreach ($ingredient in $alienList) {
        if ($alienIngredients.ContainsKey($ingredient)) {
            $alienIngredients[$ingredient]++
        } else {
            $alienIngredients.Add($ingredient,1)
        }
    }

    foreach ($ingredient in $engList) {
        if ($engIngredients.ContainsKey($ingredient)) {
            $engIngredients[$ingredient]++
        } else {
            $engIngredients.Add($ingredient,1)
        }
    }
}

# Test Input
# mxmxvkd dairy
# 

foreach ($ingredient in $alienIngredients.Keys) {
    $validateIngs = @{}
    
    $containingStrings = ($strarray -match " $ingredient ") + ($strarray -match "^$ingredient ")

    foreach ($line in $containingStrings) {
        $checkList = $line.Split("(")
        $checkList = $checkList[1].Substring(9)
        $checkList = $checkList.Substring(0,$checkList.Length - 1).Split(",")


        foreach ($item in $checkList) {
            if (!$validateIngs.ContainsKey($item)) {
                $validateIngs.Add($item,$null)
            }
        }
        
    }

    $potentialMatches = 0
    foreach ($item in $validateIngs.Keys) {
        $getItems = $strarray -match $item

        #echo "$ingredient $($containingStrings.Count) --- $item $getItemCount"

        if ($containingStrings.Count -ge $getItems.Count) {
            $count = 0
            foreach ($engIngLine in $getItems) {
                $myline = $engIngLine.Split("(")[0]
                if ($containingStrings -match "^$myline") {
                    $count++
                }
            }

            #echo "$ingredient $count --- $item $($getItems.Count)"

            if ($count -eq $getItems.Count) {
                $potentialMatches++
            }
        }
    }

    if ($potentialMatches -eq 0) {
        $safeHash.Add($ingredient,$containingStrings.Count)
    }
}

$answer = 0
foreach ($ingredient in $safeHash.Keys) {
        $answer += $safeHash[$ingredient]
}

echo $answer