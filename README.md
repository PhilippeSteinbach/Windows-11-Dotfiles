# Windows-11-Dotfiles
Dotfiles script to setup Microsoft Windows 11 for development and/or gaming.

# Download + Run Installation Process

```Powershell
$GitHubRepositoryAuthor = "PhilippeSteinbach"; `
$GitHubRepositoryName = "Windows-11-Dotfiles"; `
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; `
Invoke-Expression (Invoke-RestMethod -Uri "https://raw.githubusercontent.com/${GitHubRepositoryAuthor}/${GitHubRepositoryName}/main/Download.ps1");
```


# Run existing Scripts


```Powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; `
.\.dotfiles\Windows-11-Dotfiles-main\Download.ps1
```

```Powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass; `
.\.dotfiles\Windows-11-Dotfiles-main\src\Install.ps1
```