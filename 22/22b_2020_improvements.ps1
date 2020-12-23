<#
    Original cold runtime: ~98s
    New cold runtime     : ~83s
    Improvements:
        Don't calculate answer if it's in recursion
        Removed extra if-else surrounding block for which key list to grab for answers
        Changed key type for cards from int16 to byte to save space
        Removing $winner from final return
#>

Function Play-Game {
    Param (
        [System.Collections.Specialized.OrderedDictionary] $playerOneDeck,
        [System.Collections.Specialized.OrderedDictionary] $playerTwoDeck,
        [int] $recursed
    )

    $P1Deck = $playerOneDeck
    $P2Deck = $playerTwoDeck
    $gameStates = @{}
    $foundOldState = $false

    while ($P1Deck.Count -ne 0 -and $P2Deck.Count -ne 0) {
        $currGameState = "$($P1Deck.Keys),$($P2Deck.Keys)"
        if ($gameStates.ContainsKey($currGameState)) {
            $foundOldState = $true
            break
        } else {
            $gameStates.Add($currGameState,$null)
        }

        $P1top = $($P1Deck.Keys)[0]
        $P2top = $($P2Deck.Keys)[0]

        $P1Deck.RemoveAt(0)
        $P2Deck.RemoveAt(0)

        if (($P1top -le $P1Deck.Count) -and ($P2top -le $P2Deck.Count)) {
            $newP1Deck = [ordered]@{}
            $newP2Deck = [ordered]@{}

            foreach ($item in $($P1Deck.Keys)[0..($P1top - 1)]) {
                $newP1Deck.Add($item,$null)
            }
            foreach ($item in $($P2Deck.Keys)[0..($P2top - 1)]) {
                $newP2Deck.Add($item,$null)
            }
            
            $winner = Play-Game $newP1Deck $newP2Deck $true

            if ($winner[0] -eq "1") {
                $P1Deck.Add($P1top,$null)
                $P1Deck.Add($P2top,$null)
            } else {
                $P2Deck.Add($P2top,$null)
                $P2Deck.Add($P1top,$null)
            }
        } elseif ($P1top -gt $P2top) {
            $P1Deck.Add($P1top,$null)
            $P1Deck.Add($P2top,$null)
        } else {
            $P2Deck.Add($P2top,$null)
            $P2Deck.Add($P1top,$null)
        }
    }

    if ($foundOldState -or ($P1Deck.Count -gt 0)) {
        $winner = "1"
    } else {
        $winner = "2"
    }

    # Don't calculate answer unless it's the starting game
    if ($recursed) {
        echo $winner
    } else {
        if ($winner -eq "1") {
            $keyList = $($P1Deck.Keys)
        } else {
            $keyList = $($P2Deck.Keys)
        }
        
        $answer = [int64] 0

        while ($count -gt 0) {
            $answer += $keyList[50 - $count] * $count
            $count--
        }

        echo "$answer"
    }
}

$strarray = Get-Content in.txt

$endP1Line = $strarray.IndexOf("")

$P1Deck = [ordered]@{}
$P2Deck = [ordered]@{}

$count = 0

for ($i = 1;$i -lt $endP1Line;$i++) {
    $P1Deck.Add([byte]$strarray[$i],$null)
    $count++
}

for ($i = ($endP1Line + 2);$i -lt $strarray.Count;$i++) {
    $P2Deck.Add([byte]$strarray[$i],$null)
    $count++
}

Play-Game $P1Deck $P2Deck $false