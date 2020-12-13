<#
You start on the open square (.) in the top-left corner and need to reach the bottom (below the bottom-most row on your map).

The toboggan can only follow a few specific slopes (you opted for a cheaper model that prefers rational numbers); start by counting all the trees you would encounter for the slope right 3, down 1:

right 3 down 1
#>

$strarray = Get-Content in.txt

$height = $strarray.Count
$width = $strarray[0].Length

$trees = 0
$xpos = 0
$ypos = 0
while ($ypos -lt $height) {
    
    if ($strarray[$ypos][$xpos] -eq "#") {
        $trees++
    }

    $xpos += 3
    if ($xpos -ge $width) {
        $xpos = $xpos - $width
    }
    $ypos += 1
    $i++ # After submission review this does nothing, originally was going to use $i instead of $ypos on loop condition
}

Write-Output "Your tree count is: $trees"