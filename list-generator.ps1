$programs = [System.Collections.Generic.List[System.Object]](choco list --localonly) #grabs the stuff installed
$programs.RemoveAt(0) #removes the First line (junk)
$programs.RemoveAt($programs.Count - 1) #Removes the last line (junk)

$programs = $programs | ForEach-Object {
    $_ = $_.Split(" ")[0]
    $_
    }

Echo $programs

$input = Read-Host -Prompt "Do you accept these programs? Yes = [Y] No = [N]"
$input = $input.ToLower

if ( $input = "y" ) { #if statements to read input
    #do junk
    }
ElseIf ( $input = "n" ) {
    echo "Bye bye"
    }
Else {
    echo "Not valid input"
    }
