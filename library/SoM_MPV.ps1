function Wait-AnyKey {
    Write-Host "Press any key to exit..."
    try {
        [void][System.Console]::ReadKey($true)
    } catch {
        Read-Host | Out-Null
    }
}

Clear-Host
Write-Host "==========================================================" -ForegroundColor DarkYellow
Write-Host "        _____         __  ___   __  ___ ____  _    __" -ForegroundColor DarkYellow
Write-Host "       / ___/ ____   /  |/  /  /  |/  // __ \| |  / /" -ForegroundColor DarkYellow
Write-Host "       \__ \ / __ \ / /|_/ /  / /|_/ // /_/ /| | / / " -ForegroundColor DarkYellow
Write-Host "      ___/ // /_/ // /  / /  / /  / // ____/ | |/ /  " -ForegroundColor DarkYellow
Write-Host "     /____/ \____//_/  /_/  /_/  /_//_/      |___/   " -ForegroundColor DarkYellow
Write-Host ""
Write-Host "================== Setup 1.1 (07/15/26) ==================" -ForegroundColor DarkYellow

Write-Host "1) Portable" -ForegroundColor Blue
Write-Host "   - All MPV files remain inside a single folder."
Write-Host "   - This folder can reside anywhere in your user folders."
Write-Host "   - Run again to update and replace existing portable."

Write-Host "==========================================================" -ForegroundColor DarkYellow
Write-Host "2) Install" -ForegroundColor Green
Write-Host "   - Installs MPV into C:\Program Files\MPV."
Write-Host "   - Adds shortcuts and integrates MPV into your system."
Write-Host "   - Run again to update and replace existing install."

Write-Host "==========================================================" -ForegroundColor DarkYellow
Write-Host "3) Uninstall" -ForegroundColor Red
Write-Host "   - Removes MPV from Default Programs & Apps."
Write-Host "   - Deletes MPV from C:\Program Files\MPV."
Write-Host "   - Deletes MPV shortcut from Desktop."
Write-Host "   - Deletes MPV from Windows Start Menu."
Write-Host "   - Deletes MPV folder from AppData."
Write-Host "==========================================================" -ForegroundColor DarkYellow

Write-Host "Enter " -NoNewline
Write-Host "1 "-ForegroundColor Blue -NoNewline
Write-Host "for " -NoNewline
Write-Host "Portable" -ForegroundColor Blue -NoNewline
Write-Host ","-NoNewline
Write-Host " 2" -ForegroundColor Green -NoNewline
Write-Host " for " -NoNewline
Write-Host "Install" -ForegroundColor Green -NoNewline
Write-Host ", or " -NoNewline
Write-Host "3 " -ForegroundColor Red -NoNewline
Write-Host "to " -NoNewline
Write-Host "Uninstall" -ForegroundColor Red -NoNewline
Write-Host ": " -NoNewline
$choice = Read-Host

$protectedPaths = @(
    "C:\Windows",
    "C:\Program Files",
    "C:\Program Files (x86)",
    "C:\ProgramData",
    "C:\Users\Default",
    "C:\Users\All Users",
    "C:\Recovery",
    "C:\System Volume Information",
    "C:\PerfLogs"
)

$currentPath = $PWD.Path
$currentPathTrimmed = $currentPath.TrimEnd('\')
$homeTrimmed = $HOME.TrimEnd('\')

$isProtected = $false
$matchedReason = $null

foreach ($p in $protectedPaths) {
    if ($currentPath -like "$p*") {
        $isProtected = $true
        $matchedReason = $p
        break
    }
}

if (-not $isProtected -and $currentPathTrimmed -ieq $homeTrimmed) {
    $isProtected = $true
    $matchedReason = $HOME
}

if ($isProtected) {
    $target = [Environment]::GetFolderPath([Environment+SpecialFolder]::DesktopDirectory)
    if ([string]::IsNullOrWhiteSpace($target) -or -not (Test-Path -Path $target)) {
        $target = $HOME
    }

    Write-Host "Protected folder detected ($matchedReason) — switching to $target" -ForegroundColor Yellow
    try {
        Set-Location -Path $target -ErrorAction Stop
    } catch {
        try {
            Set-Location -Path $HOME -ErrorAction Stop
        } catch {
            Write-Host "Could not switch to a safe folder: $_" -ForegroundColor Red
            Wait-AnyKey
            exit
        }
    }
}

switch ($choice) {
    '1' {
        $BatFileName = "SoM_MPV_Builder.bat"
        $BatUrl = "https://gist.githubusercontent.com/JySzE/0d6417c84deceda8326e38804d31015b/raw/"
    }

    '2' {
        $BatFileName = "SoM_MPV_Installer.bat"
        $BatUrl = "https://gist.githubusercontent.com/JySzE/07e04bc5f01c5d30850a494e7297db42/raw/"
    }

    '3' {
        $BatFileName = "SoM_MPV_Uninstaller.bat"
        $BatUrl = "https://gist.githubusercontent.com/JySzE/9f99789bc42710fba2fde19f8255b292/raw/"
    }

    default {
        Write-Host ""
        Write-Host "Invalid selection. Please choose 1, 2, or 3." -ForegroundColor Red
        Wait-AnyKey
        exit
    }
}

$CurrentDirectory = $PWD.Path
$SetPath = Join-Path -Path $CurrentDirectory -ChildPath $BatFileName

try {
    Invoke-WebRequest -Uri $BatUrl -OutFile $SetPath -ErrorAction Stop
} catch {
    Write-Host ""
    Write-Host "Failed to download $BatUrl -> $SetPath : $_" -ForegroundColor Red
    Wait-AnyKey
    exit
}

try {
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    $build = [int]$os.BuildNumber
} catch {
    Write-Host ""
    Write-Host "Could not query OS build via CIM. Falling back to System.Environment." -ForegroundColor Yellow
    $verObj = [System.Environment]::OSVersion.Version
    $build = [int]$verObj.Build
}

if ($build -ge 22000) {
    Write-Host "Windows 11 detected — launching with conhost.exe..."
    Start-Process -FilePath "conhost.exe" -ArgumentList "`"$SetPath`""
} else {
    Write-Host "Windows 10 detected — launching with cmd.exe..."
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$SetPath`""
}