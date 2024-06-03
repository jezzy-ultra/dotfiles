# aliases
Set-Alias -Name touch -Value New-Item
Set-Alias -Name which -Value where.exe


# colors
Set-PSReadLineOption -Colors @{
    Command = "#83D5DC"
    Comment = "#707070"
    ContinuationPrompt = "#DDDDDD"
    Default = "#DDDDDD"
    Emphasis = "#8EECBA"
    Error = "#FF5E5E"
    InlinePrediction = "`e[97;2;3m"
    Keyword = "#F8A3BB"
    ListPrediction = "`e[33m"
    ListPredictionSelected = "`e[48;5;238m"
    ListPredictionTooltip = "`e[97;2;3m"
    Member = "#DDDDDD"
    Number = "#C69DEE"
    Operator = "#FF5E5E"
    Parameter = "`e[94;2;3m"
    Selection = "`e[30;47m"
    String = "#A4C474"
    Type = "#F3937E"
    Variable = "#ECC7A5"
}


# shell integration marks
$Global:__LastHistoryId = -1

function Global:__Terminal-Get-LastExitCode {
    if ($? -eq $True) {
        return 0
    }
    $LastHistoryEntry = $(Get-History -Count 1)
    $IsPowerShellError = $Error[0].InvocationInfo.HistoryId -eq $LastHistoryEntry.Id
    if ($IsPowerShellError) {
        return -1
    }
    return $LastExitCode
}

function prompt {
    # First, emit a mark for the _end_ of the previous command.
    $gle = $(__Terminal-Get-LastExitCode);
    $LastHistoryEntry = $(Get-History -Count 1)
    # Skip finishing the command if the first command has not yet started
    if ($Global:__LastHistoryId -ne -1) {
        if ($LastHistoryEntry.Id -eq $Global:__LastHistoryId) {
            # Don't provide a command line or exit code if there was no history entry (eg. ctrl+c, enter on no command)
            $out += "`e]133;D`a"
        } else {
            $out += "`e]133;D;$gle`a"
        }
    }

    $loc = $($executionContext.SessionState.Path.CurrentLocation);

    # Prompt started
    $out += "`e]133;A$([char]07)";

    # CWD
    $out += "`e]9;9;`"$loc`"$([char]07)";

    # (your prompt here)
    $out += "PWSH $loc$('>' * ($nestedPromptLevel + 1)) ";

    # Prompt ended, Command started
    $out += "`e]133;B$([char]07)";

    $Global:__LastHistoryId = $LastHistoryEntry.Id

    return $out
}


# oh-my-posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/catppuccin_frappe.omp.json" | Invoke-Expression


# Chocolatey
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile))
{
    Import-Module "$ChocolateyProfile"
}


# pip
if ((Test-Path Function:\TabExpansion) -and -not `
    (Test-Path Function:\_pip_completeBackup)) {
    Rename-Item Function:\TabExpansion _pip_completeBackup
}
function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1].TrimStart()
    if ($lastBlock.StartsWith("pip ")) {
        $Env:COMP_WORDS=$lastBlock
        $Env:COMP_CWORD=$lastBlock.Split().Length - 1
        $Env:PIP_AUTO_COMPLETE=1
        (& pip).Split()
        Remove-Item Env:COMP_WORDS
        Remove-Item Env:COMP_CWORD
        Remove-Item Env:PIP_AUTO_COMPLETE
    }
    elseif (Test-Path Function:\_pip_completeBackup) {
        # Fall back on existing tab expansion
        _pip_completeBackup $line $lastWord
    }
}
