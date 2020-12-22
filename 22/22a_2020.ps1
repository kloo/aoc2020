<#

#>

Function Play-Game {
    Param (
        [System.Collections.Specialized.OrderedDictionary] $playerOneDeck,
        [System.Collections.Specialized.OrderedDictionary] $playerTwoDeck
    )

    $P1Deck = $playerOneDeck
    $P2Deck = $playerTwoDeck

    while ($P1Deck.Count -ne 0 -and $P2Deck.Count -ne 0) {

        $P1top = $($P1Deck.Keys)[0]
        $P2top = $($P2Deck.Keys)[0]

        $P1Deck.RemoveAt(0)
        $P2Deck.RemoveAt(0)

        if ($P1top -gt $P2top) {
            $P1Deck.Add($P1top,$null)
            $P1Deck.Add($P2top,$null)
        } else {
            $P2Deck.Add($P2top,$null)
            $P2Deck.Add($P1top,$null)
        }
    }

    if ($P1Deck.Count -gt 0) {
        $keyList = $($P1Deck.Keys)
    } else {
        $keyList = $($P2Deck.Keys)
    }

    $answer = [int64] 0

    while ($count -gt 0) {
        $answer += $keyList[50 - $count] * $count
        $count--
    }

    echo $answer
}

$strarray = Get-Content in.txt

$endP1Line = $strarray.IndexOf("")

$P1Deck = [ordered]@{}
$P2Deck = [ordered]@{}

$count = 0

for ($i = 1;$i -lt $endP1Line;$i++) {
    $P1Deck.Add([int16]$strarray[$i],$null)
    $count++
}

for ($i = ($endP1Line + 2);$i -lt $strarray.Count;$i++) {
    $P2Deck.Add([int16]$strarray[$i],$null)
    $count++
}

$answer = Play-Game $P1Deck $P2Deck
$answer