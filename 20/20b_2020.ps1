<#
    1897 too lo (35 sm)
    2122 too lo (20 sm)
    2272 too hi (10 sm)
    2257 too ?? (11 sm)
    2242 too ?? (12 sm)
    2227 too ?? (13 sm)
    2212 too ?? (14 sm) 9:23
    2197 too ?? (15 sm) 2:46
    2182 too ??(16 sm)
    2167 too ?? (17 sm)
    2152 the answer (18 sm)
    2137 (19 sm)
#>

$strarray = Get-Content trimmed_b.txt

$size = $strarray.Length

$poundCount = 0
foreach ($row in $strarray) {
    for ($i = 0;$i -lt $size;$i++) {
        if ($row[$i] -eq "#") {
            $poundCount++
        }
    }
}
#echo $poundCount # 2422 total