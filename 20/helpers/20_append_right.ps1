$str1 = Get-Content helpers/leftside.txt
$str2 = Get-Content helpers/rightside.txt


$size = $str1.Count

for($i = 0;$i -lt $size;$i++) {
    echo "$($str1[$i]) $($str2[$i])"

    if ($i -eq 0) {
        Write-Output "$($str1[$i]) $($str2[$i])" > helpers/leftside.txt
    } else {
        Write-Output "$($str1[$i]) $($str2[$i])" >> helpers/leftside.txt
    }
}