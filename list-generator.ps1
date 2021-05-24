Clear-Host

Set-Location $PSScriptRoot

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
    
    $output_file = $programs | ForEach-Object {
        $_ = $_.Insert($_.Length, " -y")
        $_ = $_.Insert(0, "cinst ")
        $_
        }

    $output_file = [System.Collections.Generic.List[System.Object]]($output_file)
    $output_file.Insert(0, "iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex")
    $output_file.Insert(0, "`Clear-Host")
    $output_file = $output_file + "Clear-Host"
    $output_file = $output_file + "echo `"All done!`""
    $output_file = $output_file + "Pause"
    Clear-Host
    $output_file >> choco_installer_script.ps1
    echo "Done :)"
    Pause

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
