function Initialize-DotfilesEnvironment {
    param (
        [string]$RepositoryAuthor = "PhilippeSteinbach",
        [string]$RepositoryName = "Windows-11-Dotfiles"
    )

    # Define variables
    $ScriptVersion = "0.0.1"
    $GitHubRepositoryAuthor = $RepositoryAuthor
    $GitHubRepositoryName = $RepositoryName
    $DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles"
    $DotfilesExists = Test-Path -Path $DotfilesFolder
    $MainFolderPath = Join-Path -Path $DotfilesFolder -ChildPath "${GitHubRepositoryName}-main"
    $DotfilesWorkFolder = Join-Path -Path $MainFolderPath -ChildPath "src"
    $DotfilesConfigFile = Join-Path -Path $DotfilesFolder -ChildPath "config.json"
    $DotfilesHelpersFolder = Join-Path -Path $DotfilesWorkFolder -ChildPath "Helper"

    $envVars = @{
        ScriptVersion = $ScriptVersion
        GitHubRepositoryAuthor = $GitHubRepositoryAuthor
        GitHubRepositoryName = $GitHubRepositoryName
        DotfilesFolder = $DotfilesFolder
        DotfilesExists = $DotfilesExists
        DotfilesWorkFolder = $DotfilesWorkFolder
        DotfilesConfigFile = $DotfilesConfigFile
        DotfilesHelpersFolder = $DotfilesHelpersFolder
        MainFolderPath = $MainFolderPath
    }

    return New-Object PSObject -Property $envVars
}