function Set-Workspace-Folder-Windows {
    $workspaceFolder = Join-Path -Path $WorkspaceDisk -ChildPath "Workspace";

    Write-Host $WorkspaceDisk;
    Write-Host $workspaceFolder;

    if (-not (Test-Path -Path $workspaceFolder)) {
        Write-Host "Erstelle Windows 11 Workspace-Ordner..." -ForegroundColor "Green";
        New-Item -Path $workspaceFolder -ItemType Directory;
    }
}

function Set-Workspace-Folder-Ubuntu {
    $workspaceFolder = Join-Path -Path $HOME -ChildPath "Workspace";

    if (-not (Test-Path -Path $workspaceFolder)) {
        Write-Host "Erstelle Ubuntu Workspace-Ordner..." -ForegroundColor "Green";
        wsl mkdir -p -v ~/Workspace;
    }
}
