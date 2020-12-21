<# #>

$strarray = Get-Content in.txt

$alienIngredients = @{}
$engIngredients = @{}

$translateHash = @{}

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
    $validateIngs = @()
    $currCount = $alienIngredients[$ingredient]

    $translateHash.Add($ingredient,@())

    foreach ($engIng in $engIngredients.Keys) {
        if ($engIngredients[$engIng] -eq $currCount) {
            #echo "$ingredient $engIng"
            $validateIngs += $engIng
        }
    }

    foreach ($checkIng in $validateIngs) {
        $validateArray = $strarray -match $checkIng
        $isFullMatch = $true

        foreach ($line in $validateArray) {
            #echo "$line --- $ingredient --- $engIng"
            if (!($line.Contains($ingredient))) {
                #echo "$line --- $ingredient --- $checkIng"
                $isFullMatch = $false
            } #else { echo "$line --- $ingredient --- $engIng" }
        }

        if ($isFullMatch) {
            #echo "$ingredient --- $engIng"
            $translateHash[$ingredient] += $engIng
        }
    }
}

$answer = 0
foreach ($ingredient in $translateHash.Keys) {
    if ($translateHash[$ingredient].Count -eq 0) {
        $answer += $alienIngredients[$ingredient]
    }
}

echo $answer