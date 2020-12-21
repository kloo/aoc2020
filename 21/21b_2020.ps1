<#

2103 too high
2070 too low
2075
#>

$strarray = Get-Content in.txt

$alienIngredients = @{}
$engIngredients = @{}

$safeHash = @{}
$dangerHash = @{}

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
        $getItems = ($strarray -match " $item") + ($strarray -match ",$item")

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
                if ($dangerHash.ContainsKey($item)) {
                    $dangerHash[$item] += $ingredient
                } else {
                    $dangerHash.Add($item,@($ingredient))
                }
            }
        }
    }

    if ($potentialMatches -eq 0) {
        $safeHash.Add($ingredient,$containingStrings.Count)
    }
}

$answer = 0
$keys = $dangerHash.Keys
$needsTranslation = $keys.Count
$translateTable = @{}
while ($needsTranslation -gt 0) {
    $newHash = @{}

    foreach ($key in $keys) {
        $currCheck = $key
        if ($dangerHash[$currCheck].Count -eq 1) {
            $currKey = $dangerHash[$currCheck][0]

            $translateTable.Add($currKey,$currCheck)
        } else {
            $newArr = @()

            foreach ($possKey in $dangerHash[$currCheck]) {
                if (!$translateTable.ContainsKey($possKey)) {
                    $newArr += $possKey
                }
            }

            if ($newArr.Count -eq 1) {
                $translateTable.Add($newArr[0],$currCheck)
            } else {
                $newHash.Add($currCheck,$newArr)
            }
        }
    }

    $dangerHash = $newHash

    $keys = $dangerHash.Keys
    $needsTranslation = $keys.Count
}

$keys = ($translateTable.GetEnumerator() | Sort-Object -Property Value).Key
$answerString = ""

foreach ($key in $keys) {
    $answerString += $key + ","
}

$answerString.Substring(0,$answerString.Length - 1)
