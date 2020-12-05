<#
You start on the open square (.) in the top-left corner and need to reach the bottom (below the bottom-most row on your map).

The toboggan can only follow a few specific slopes (you opted for a cheaper model that prefers rational numbers);
start by counting all the trees you would encounter for the slope right 3, down 1.

Determine the number of trees you would encounter if, for each of the following slopes,
you start at the top-left corner and traverse the map all the way to the bottom:

Right 1, down 1.
Right 3, down 1. (This is the slope you already checked.)
Right 5, down 1.
Right 7, down 1.
Right 1, down 2.

#>

$strarray = Get-Content in.txt

$height = $strarray.Count
$width = $strarray[0].Length

$product = 1

$moveArray = @(@(1,1),@(3,1),@(5,1),@(7,1),@(1,2))

for ($iter = 0;$iter -lt $moveArray.Length;$iter++) {
    $trees = 0

    $xpos = 0
    $ypos = 0

    $xspeed = $moveArray[$iter][0]
    $yspeed = $moveArray[$iter][1]

    while ($ypos -lt $height) {
        if ($strarray[$ypos][$xpos] -eq "#") {
            $trees++
        }

        $xpos += $xspeed
        if ($xpos -ge $width) {
            $xpos = $xpos - $width
        }
        $ypos += $yspeed
    }

    Write-Output "Path right $xspeed down $yspeed is: $trees"
    $product = $product * $trees
}

Write-Output "Your answer is: $product"