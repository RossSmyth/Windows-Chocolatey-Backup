<#

MIT License

Copyright (c) 2017 treefroog

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#>

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
