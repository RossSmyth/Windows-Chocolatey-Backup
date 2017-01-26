﻿Clear-Host

$programs = [System.Collections.Generic.List[System.Object]](choco list --localonly) #grabs the stuff installed
$programs.RemoveAt(0) #removes the First line (junk)
$programs.RemoveAt($programs.Count - 1) #Removes the last line (junk)

$programs = $programs | ForEach-Object {
    $_ = $_.Split(" ")[0]
    $_
    }

Echo $programs

$user_input = Read-Host -Prompt "`nDo you accept these programs? `nYes = [Y] No = [N] `n"
$user_input = $user_input.ToLower()

if ( $user_input -eq "y" ) { #if statements to read input
    echo "later"
    #do junk
    }
ElseIf ( $user_input -eq "n" ) {
    echo "`nBye bye `n"
    Pause
    Exit
    }
Else {
    echo "`nNot valid input `n"
    Pause
    Exit
    }
