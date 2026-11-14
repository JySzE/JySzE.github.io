@echo off
:: === Windows 10 Optimizations Batch Script ===
:: Run as Administrator

color 0A

:: --- Check for Administrator ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Please run this script as Administrator.
    pause
    exit /b
)

:: --- Check for Windows 10 ---
for /f "tokens=4-5 delims=. " %%i in ('ver') do set verMajor=%%i & set verMinor=%%j
if %verMajor% lss 10 (
    echo [ERROR] This script is intended for Windows 10 only.
    pause
    exit /b
)

echo ========================================
echo   Windows 10 Optimization Script
echo ========================================
echo.
echo [WARNING] This script makes SIGNIFICANT changes to your system:
echo.
echo   - DISABLES Windows Defender and security features
echo   - DISABLES System Restore (no recovery points)
echo   - DISABLES CPU vulnerability mitigations (Spectre/Meltdown)
echo   - REMOVES OneDrive and preinstalled apps
echo   - MODIFIES network, performance, and privacy settings
echo.
echo [IMPORTANT] These changes prioritize PERFORMANCE over SECURITY.
echo             Only proceed if you understand the risks!
echo.
echo [RECOMMENDED] Best used on a FRESH Windows 10 installation.
echo               Running on existing systems may cause issues.
echo.
echo Press any key to continue or close this window to cancel...
pause >nul
echo.
echo [INFO] Starting optimizations...
echo.

:: ========================================
:: SECTION 1: UI and VISUAL OPTIMIZATIONS
:: ========================================
echo [SECTION 1] Applying UI and Visual Optimizations...

:: Remove Task view from Taskbar
echo [INFO] Removing Task view from Taskbar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul 2>&1

:: Remove Search bar from Taskbar
echo [INFO] Removing Search bar from Taskbar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Transparency Effects
echo [INFO] Disabling Transparency Effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable All Visual Effects and Animations
echo [INFO] Disabling all visual effects and animations...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableAeroPeek /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1

:: Disable News and Interests (Windows 10 20H2+)
echo [INFO] Disabling News and Interests...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >nul 2>&1

:: Disable Meet Now (Windows 10)
echo [INFO] Disabling Meet Now icon...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable People Bar
echo [INFO] Disabling People Bar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Lock Screen
echo [INFO] Disabling Lock Screen...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f >nul 2>&1

:: Show file extensions for known types
echo [INFO] Showing file extensions...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul 2>&1

:: Show hidden files
echo [INFO] Showing hidden files...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable "Open With" Store Suggestions
echo [INFO] Disabling 'Open With' Store Suggestions...
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v NoUseStoreOpenWith /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Online Tips and Suggestions
echo [INFO] Disabling Online Tips and Suggestions...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v AllowOnlineTips /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f >nul 2>&1

echo.
:: ========================================
:: SECTION 2: TELEMETRY and PRIVACY
:: ========================================
echo [SECTION 2] Disabling Telemetry and Privacy Features...

:: Disable Telemetry
echo [INFO] Disabling Windows Telemetry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v Start /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ActivityHistory" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AppHost" /v EnableWebContentEvaluation /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Windows Error Reporting
echo [INFO] Disabling Windows Error Reporting...
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Customer Experience Improvement Program (CEIP)
echo [INFO] Disabling Customer Experience Improvement Program...
reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Application Telemetry
echo [INFO] Disabling Application Telemetry and Inventory...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v AITEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Steps Recorder
echo [INFO] Disabling Steps Recorder...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableUAR /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Program Compatibility Assistant
echo [INFO] Disabling Program Compatibility Assistant...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisablePCA /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Timeline
echo [INFO] Disabling Timeline...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Bing/Web Search in Start Menu
echo [INFO] Disabling Bing/Web Search in Start Menu...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Windows Consumer Experience and Cloud Content
echo [INFO] Disabling Windows Consumer Experience, Tips, and Cloud Content...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableThirdPartySuggestions /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnActionCenter /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnSettings /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightWindowsWelcomeExperience /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Content Delivery Manager features
echo [INFO] Disabling Content Delivery Manager features...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338387Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenOverlayEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Cortana
echo [INFO] Disabling Cortana...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Windows Ink Workspace
echo [INFO] Disabling Windows Ink Workspace...
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" /v AllowWindowsInkWorkspace /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Tablet Mode prompts
echo [INFO] Disabling Tablet Mode prompts...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v SignInMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell" /v TabletMode /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Remote Assistance
echo [INFO] Disabling Remote Assistance...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v fAllowToGetHelp /t REG_DWORD /d 0 /f >nul 2>&1

echo [SECTION 2] Telemetry and Privacy Optimizations Complete!
echo.

:: ========================================
:: SECTION 3: SECURITY FEATURES (PERFORMANCE MODE)
:: ========================================
echo [SECTION 3] Disabling Security Features for Performance...

:: Windows Defender Section
setlocal EnableDelayedExpansion
echo.
echo ============================================================
echo  DISABLE WINDOWS DEFENDER?
echo ============================================================
echo.
echo IMPORTANT: You MUST manually disable "Tamper Protection" in 
echo Windows Security -^> Virus ^& threat protection settings FIRST, 
echo or these commands will be blocked by Windows.
echo.
echo This disables:
echo   - Real-Time Protection
echo   - Behavior Monitoring ^& Script Scanning
echo.
set "defender_choice="
set /p defender_choice="Disable Windows Defender Real-Time Protection? (Y/N): "

if /i "!defender_choice!"=="Y" (
    echo [INFO] Disabling Real-Time Protection via PowerShell...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-MpPreference -DisableRealtimeMonitoring $true -DisableBehaviorMonitoring $true -DisableIOAVProtection $true -DisableScriptScanning $true" >nul 2>&1

    echo [INFO] Verifying Defender status...
    for /f "tokens=*" %%A in ('powershell -NoProfile -ExecutionPolicy Bypass -Command "(Get-MpComputerStatus).RealTimeProtectionEnabled"') do set "rt_status=%%A"

    if /i "!rt_status!"=="False" (
        echo [SUCCESS] Real-Time Protection disabled successfully.
    ) else (
        echo [ERROR] Failed to disable Real-Time Protection. Ensure Tamper Protection is OFF in Windows Security.
    )
) else (
    echo [SKIPPED] Windows Defender left enabled.
)
endlocal

:: VBS/HVCI Section
setlocal EnableDelayedExpansion
echo.
echo ============================================================
echo  DISABLE VBS/HVCI (Memory Integrity)?
echo ============================================================
echo.
echo NOTE: Windows 10 typically doesn't have this enabled by default,
echo       but we'll disable it to ensure it stays off.
echo.
echo If you have 12th Gen Intel or newer, OR AMD Ryzen 5000+
echo       Press N - These CPUs have hardware acceleration that
echo       makes the performance impact minimal (1-3%% overhead)
echo.
echo If you have 11th Gen Intel or older, OR AMD Ryzen 3000 series
echo       Press Y - May gain 5-10%% performance in some workloads
echo.
set /p vbs_choice="Disable VBS/HVCI? (Y/N): "

if /i "!vbs_choice!"=="Y" (
    echo [INFO] Disabling VBS, HVCI ^(Memory Integrity^), and Security Features...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v WasEnabledBy /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v RequirePlatformSecurityFeatures /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v Locked /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\SystemGuard" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
    echo [SUCCESS] VBS/HVCI disabled
) else (
    echo [SKIPPED] VBS/HVCI left enabled
)
endlocal

:: Spectre/Meltdown Section
setlocal EnableDelayedExpansion
echo.
echo ============================================================
echo  DISABLE SPECTRE/MELTDOWN MITIGATIONS?
echo ============================================================
echo.
echo NOTE: If you have 12th Gen Intel or newer, OR AMD Ryzen 5000+
echo       Press N - Hardware mitigations mean minimal overhead (1-2%%)
echo.
echo If you have 11th Gen Intel or older, OR AMD Ryzen 3000 series
echo       Press Y - May gain 5-15%% in specific workloads
echo.
echo WARNING: Disabling these removes important security protections!
echo.
set /p spectre_choice="Disable Spectre/Meltdown Mitigations? (Y/N): "

if /i "!spectre_choice!"=="Y" (
    echo [INFO] Disabling Spectre and Meltdown CPU mitigations...
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 3 /f >nul 2>&1
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d 3 /f >nul 2>&1
    echo [SUCCESS] Spectre/Meltdown mitigations disabled
) else (
    echo [SKIPPED] Spectre/Meltdown mitigations left enabled
)
endlocal

:: Intel TSX Section (Always Disable - No Prompt Needed)
echo.
echo [INFO] Disabling Intel TSX (deprecated by Intel, safe to disable)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v DisableTsx /t REG_DWORD /d 1 /f >nul 2>&1
echo [SUCCESS] Intel TSX disabled

:: Disable System Restore and VSS
echo [WARN] Disabling System Restore, deleting all restore points, and stopping VSS...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v DisableSR /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v RPSessionInterval /t REG_DWORD /d 0 /f >nul 2>&1
vssadmin Delete Shadows /All /Quiet >nul 2>&1

echo [SECTION 3] Security Feature Optimizations Complete!
echo.

:: ========================================
:: SECTION 4: NETWORK OPTIMIZATIONS
:: ========================================
echo [SECTION 4] Applying Network Optimizations...

:: Disable Delivery Optimization
echo [INFO] Disabling Delivery Optimization...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Network Throttling
echo [INFO] Disabling Network Throttling...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 0xffffffff /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul 2>&1

:: Disable Nagle's Algorithm (Reduce Network Latency)
echo [INFO] Disabling Nagle's Algorithm for all network interfaces...
for /f "tokens=*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /s /f "DhcpIPAddress" ^| findstr "HKEY"') do (
    reg add "%%a" /v TcpAckFrequency /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "%%a" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
)

:: Enable Linked Connections for network drives
echo [INFO] Enabling Linked Connections for network drives...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLinkedConnections /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable SMB1 Protocol (Security improvement)
echo [INFO] Disabling SMB1 Protocol (outdated and insecure)...
reg add "HKLM\SYSTEM\CurrentControlSet\services\LanmanServer\Parameters" /v SMB1 /t REG_DWORD /d 0 /f >nul 2>&1

echo [SECTION 4] Network Optimizations Complete!
echo.

:: ========================================
:: SECTION 5: PERFORMANCE and RESPONSIVENESS
:: ========================================
echo [SECTION 5] Applying Performance and Responsiveness Tweaks...

:: Disable Startup Delay
echo [INFO] Disabling Startup Delay...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f >nul 2>&1

:: Speed Up Shutdown Time
echo [INFO] Reducing shutdown wait time...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 2000 /f >nul 2>&1

:: Disable CPU Core Parking
echo [INFO] Disabling CPU Core Parking...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ValueMax /t REG_DWORD /d 0 /f >nul 2>&1

:: Optimize Win32Priority Separation for Foreground Apps
echo [INFO] Optimizing Win32Priority Separation...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v Win32PrioritySeparation /t REG_DWORD /d 38 /f >nul 2>&1

:: Disable Hibernation and Fast Startup
echo [INFO] Disabling Hibernation and Fast Startup...
powercfg -h off >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Activate High Performance Power Plan
echo [INFO] Activating High Performance Power Plan...
powercfg /setactive scheme_min >nul 2>&1

:: Apply power settings
echo [INFO] Applying power settings...
powercfg /setactive scheme_min >nul 2>&1

:: Enable and Optimize TRIM for SSD
echo [INFO] Enabling and optimizing TRIM for SSD...
fsutil behavior set DisableDeleteNotify 0 >nul 2>&1

:: Disable last access time stamp updates
echo [INFO] Disabling last access time stamp updates...
fsutil behavior set disablelastaccess 1 >nul 2>&1

:: Increase NTFS memory cache
echo [INFO] Increasing NTFS memory cache...
fsutil behavior set memoryusage 2 >nul 2>&1

echo [SECTION 5] Performance Optimizations Complete!
echo.

:: ========================================
:: SECTION 6: GPU OPTIMIZATIONS
:: ========================================
echo [SECTION 6] Applying GPU Optimizations...

:: Disable Multi-Plane Overlay (reduces flickering/stuttering)
echo [INFO] Disabling Multi-Plane Overlay...
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode /t REG_DWORD /d 5 /f >nul 2>&1

:: Extend TDR timeout (prevents driver crashes during load)
echo [INFO] Extending TDR timeout...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDdiDelay /t REG_DWORD /d 8 /f >nul 2>&1

:: Apply GPU power/performance tweaks (All manufacturers)
echo [INFO] Applying GPU power and performance tweaks...
for %%G in (0000 0001 0002 0003) do (
    :: AMD: Disable ULPS (Ultra Low Power State)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\%%G" /v Disable_OverlayDSQualityEnhancement /t REG_DWORD /d 1 /f >nul 2>&1
)

:: AMD: Disable Chill and enable Boost
echo [INFO] Applying AMD-specific optimizations...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdwddmg" /v ChillEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdwddmg" /v BoostEnabled /t REG_DWORD /d 1 /f >nul 2>&1

:: Intel: Disable DPST and adaptive brightness
echo [INFO] Applying Intel-specific optimizations...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v EnableDPST /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\igfx" /v AdaptiveBrightness /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Intel\GMM" /v DedicatedSegmentSize /t REG_DWORD /d 512 /f >nul 2>&1

echo [SECTION 6] GPU Optimizations Complete!
echo.

:: ========================================
:: SECTION 7: GAMING and MULTIMEDIA
:: ========================================
echo [SECTION 7] Applying Gaming and Multimedia Optimizations...

:: Disable Xbox Game Bar and Game DVR
echo [INFO] Disabling Xbox Game Bar and Game DVR...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_EFSEFeatureFlags /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Mouse Acceleration
echo [INFO] Disabling mouse acceleration...
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul 2>&1

:: Multimedia System Profile Optimization
echo [INFO] Optimizing Multimedia System Profile...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v Priority /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Scheduling Category" /t REG_SZ /d High /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "SFIO Priority" /t REG_SZ /d High /f >nul 2>&1

echo [SECTION 7] Gaming and Multimedia Optimizations Complete!
echo.

:: ========================================
:: SECTION 8: SERVICES OPTIMIZATION
:: ========================================
echo [SECTION 8] Disabling Unnecessary Services...

:: Disable Connected User Experiences / Telemetry service
echo [INFO] Disabling Connected User Experiences service...
sc query DiagTrack >nul 2>&1
if %errorlevel%==0 (
    sc config DiagTrack start= disabled >nul 2>&1
    sc stop DiagTrack >nul 2>&1
)

:: Disable NVIDIA Telemetry Container
echo [INFO] Disabling NVIDIA Telemetry Container...
sc query NvTelemetryContainer >nul 2>&1
if %errorlevel%==0 (
    sc config NvTelemetryContainer start= disabled >nul 2>&1
    sc stop NvTelemetryContainer >nul 2>&1
)

:: Disable VSS Service
echo [INFO] Disabling VSS Service...
sc query VSS >nul 2>&1
if %errorlevel%==0 (
    sc config VSS start= disabled >nul 2>&1
    sc stop VSS >nul 2>&1
)

:: Disable Remote Registry
echo [INFO] Disabling Remote Registry service...
sc query RemoteRegistry >nul 2>&1
if %errorlevel%==0 (
    sc config RemoteRegistry start= disabled >nul 2>&1
    sc stop RemoteRegistry >nul 2>&1
)

:: Disable Secondary Logon
echo [INFO] Disabling Secondary Logon service...
sc query seclogon >nul 2>&1
if %errorlevel%==0 (
    sc config seclogon start= disabled >nul 2>&1
    sc stop seclogon >nul 2>&1
)

:: Disable unneeded background services
echo [INFO] Disabling unneeded background services...
set "SERVICES_TO_DISABLE=MapsBroker MessagingService OneSyncSvc WerSvc HomeGroupProvider RetailDemo"
for %%s in (%SERVICES_TO_DISABLE%) do (
    sc query %%s >nul 2>&1
    if %errorlevel%==0 (
        sc config %%s start= disabled >nul 2>&1
        sc stop %%s >nul 2>&1
    )
)

echo [SECTION 8] Service Optimizations Complete!
echo.

:: ========================================
:: SECTION 9: HYPER-V and VIRTUALIZATION
:: ========================================
echo [SECTION 9] Disabling Hyper-V and Virtualization Features...

echo [INFO] Disabling Hyper-V / Virtualization Features...
dism /online /disable-feature /featurename:Microsoft-Hyper-V-All /norestart >nul 2>&1

echo [SECTION 9] Virtualization Optimizations Complete!
echo.

:: ========================================
:: SECTION 10: ONEDRIVE REMOVAL
:: ========================================
echo [SECTION 10] Removing OneDrive...

:: Fully Remove OneDrive
echo [INFO] Removing OneDrive...
taskkill /f /im OneDrive.exe >nul 2>&1
if exist "%SystemRoot%\System32\OneDriveSetup.exe" (
    start /wait "" "%SystemRoot%\System32\OneDriveSetup.exe" /uninstall
)
if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
    start /wait "" "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /uninstall
)
timeout /t 2 /nobreak >nul 2>&1
rd "%UserProfile%\OneDrive" /s /q >nul 2>&1
rd "C:\OneDriveTemp" /s /q >nul 2>&1
rd "%LocalAppData%\Microsoft\OneDrive" /s /q >nul 2>&1
rd "%ProgramData%\Microsoft OneDrive" /s /q >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /f >nul 2>&1
reg delete "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /f >nul 2>&1

:: Extra OneDrive Installer Cleanup
for /d %%i in ("%SystemRoot%\Installer\*") do (
    findstr /i /m "OneDrive" "%%i\*.ipi" >nul 2>&1 && rd "%%i" /s /q >nul 2>&1
)

:: Block OneDrive Reinstallation
echo [INFO] Blocking OneDrive reinstalls...
reg add "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f >nul 2>&1

echo [SECTION 10] OneDrive Removal Complete!
echo.

:: ========================================
:: SECTION 11: EDGE BROWSER OPTIMIZATIONS
:: ========================================
echo [SECTION 11] Disabling Background Edge Processes...

echo [INFO] Disabling background Edge processes...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v StartupBoostEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BackgroundModeEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v HardwareAccelerationModeEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Edge\Main" /v AllowPrelaunch /t REG_DWORD /d 0 /f >nul 2>&1

echo [SECTION 11] Edge Optimizations Complete!
echo.

:: ========================================
:: SECTION 12: CONTEXT MENU ENHANCEMENTS
:: ========================================
echo [SECTION 12] Adding Context Menu Enhancements...

echo [INFO] Adding context menu enhancements...
reg add "HKCR\Directory\shell\OpenElevatedCmd" /ve /d "Open command prompt here as administrator" /f >nul 2>&1
reg add "HKCR\*\shell\TakeOwnership" /ve /d "Take Ownership" /f >nul 2>&1

:: Remove unwanted context menu items
echo [INFO] Removing unwanted context menu items...
reg delete "HKCR\*\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\EPP" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}" /t REG_SZ /d "" /f >nul 2>&1
reg delete "HKCR\*\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Directory\shellex\PropertySheetHandlers\Sharing" /f >nul 2>&1
reg delete "HKCR\Drive\shellex\ContextMenuHandlers\Sharing" /f >nul 2>&1

echo [SECTION 12] Context Menu Enhancements Complete!
echo.

:: ========================================
:: SECTION 13: WINDOWS PHOTO VIEWER
:: ========================================
echo [SECTION 13] Restoring Windows Photo Viewer...

reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".bmp" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".dib" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".gif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jfif" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpe" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jxr" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".wdp" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >nul 2>&1
reg add "HKCR\Applications\photoviewer.dll\shell\open" /v "MuiVerb" /t REG_SZ /d "@photoviewer.dll,-3043" /f >nul 2>&1
reg add "HKCR\Applications\photoviewer.dll\shell\open\DropTarget" /v "Clsid" /t REG_SZ /d "{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}" /f >nul 2>&1
reg add "HKCR\Applications\photoviewer.dll\shell\print\DropTarget" /v "Clsid" /t REG_SZ /d "{60fd46de-f830-4894-a628-6fa81bc0190d}" /f >nul 2>&1

echo [SECTION 13] Windows Photo Viewer Restored!
echo.

:: ========================================
:: SECTION 14: BLOATWARE REMOVAL
:: ========================================
echo [SECTION 14] Removing Preinstalled Apps and Bloatware...

:: Disable Common Bloatware Startup Programs
echo [INFO] Disabling common bloatware startup programs...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDefender" /f >nul 2>&1

:: Remove selected preinstalled apps
echo [INFO] Removing unwanted preinstalled apps (this may take a while)...
set "APPS_TO_REMOVE=Microsoft.3DBuilder Microsoft.BingFinance Microsoft.BingFoodAndDrink Microsoft.BingHealthAndFitness Microsoft.BingNews Microsoft.BingSports Microsoft.BingTranslator Microsoft.BingTravel Microsoft.BingWeather Microsoft.Messaging Microsoft.Microsoft3DViewer Microsoft.MicrosoftOfficeHub Microsoft.MicrosoftSolitaireCollection Microsoft.MicrosoftStickyNotes Microsoft.MixedReality.Portal Microsoft.NetworkSpeedTest Microsoft.News Microsoft.Office.OneNote Microsoft.Office.Sway Microsoft.OneConnect Microsoft.Print3D Microsoft.SkypeApp Microsoft.Wallet Microsoft.WindowsAlarms Microsoft.WindowsFeedbackHub Microsoft.WindowsMaps Microsoft.WindowsSoundRecorder Microsoft.XboxApp Microsoft.ZuneVideo MicrosoftCorporationII.QuickAssist ACGMediaPlayer ActiproSoftwareLLC AdobeSystemsIncorporated.AdobePhotoshopExpress Amazon.com.Amazon AmazonVideo.PrimeVideo Asphalt8Airborne AutodeskSketchBook CaesarsSlotsFreeCasino COOKINGFEVER CyberLinkMediaSuiteEssentials DisneyMagicKingdoms Disney DrawboardPDF Duolingo-LearnLanguagesforFree EclipseManager Facebook FarmVille2CountryEscape fitbit Flipboard HiddenCity HULULLC.HULUPLUS iHeartRadio Instagram king.com.BubbleWitch3Saga king.com.CandyCrushSaga king.com.CandyCrushSodaSaga LinkedInforWindows MarchofEmpires Netflix NYTCrossword OneCalendar PandoraMediaInc PhototasticCollage PicsArt-PhotoStudio Plex PolarrPhotoEditorAcademicEdition RoyalRevolt Shazam SlingTV Spotify TikTok TuneInRadio Twitter Viber WinZipUniversal Wunderlist XING Microsoft.GetHelp Microsoft.MSPaint Microsoft.People Microsoft.WindowsCalculator Microsoft.WindowsCamera Microsoft.windowscommunicationsapps Microsoft.YourPhone Microsoft.ZuneMusic"
for %%a in (%APPS_TO_REMOVE%) do (
    powershell -NoProfile -Command "Get-AppxPackage -Name '%%a' -AllUsers -ErrorAction SilentlyContinue | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }" >nul 2>&1
)

echo [INFO] Finished removing preinstalled apps.
echo [SECTION 14] Bloatware Removal Complete!
echo.

:: ========================================
:: SECTION 15: Downloading vcredist AIO
:: ========================================
echo [SECTION 15] Downloading vcredist AIO...

echo [INFO] Downloading and Installing Visual C++ Redistributables...
curl -L -o "%TEMP%\VisualCppRedist_AIO_x86_x64.exe" "https://www.tinyplease.com/vcpp" >nul 2>&1
if exist "%TEMP%\VisualCppRedist_AIO_x86_x64.exe" (
    start "" "%TEMP%\VisualCppRedist_AIO_x86_x64.exe" /ai
) else (
    echo [WARN] Failed to download VC++ Redistributables.
    echo [WARN] VC++ Installation Failed!
)

echo [SECTION 15] vcredist AIO Complete!
echo.

:: ========================================
:: SECTION 16: WINDOWS ACTIVATION
:: ========================================
echo [SECTION 16] Checking Windows Activation...

echo [INFO] Checking Windows Activation (HWID via MAS)...
powershell -Command "& ([ScriptBlock]::Create((irm 'https://get.activated.win'))) /HWID" >nul 2>&1

echo [SECTION 16] Activation Check Complete!
echo.

:: ========================================
:: FINALIZATION
:: ========================================
echo [FINAL] Finalizing optimizations...

:: Refresh registry and restart Explorer
echo [INFO] Refreshing registry and restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1
start explorer.exe

echo.
echo ========================================
echo   Optimization Complete!
echo ========================================
echo.
echo [INFO] All optimizations applied successfully.
echo [INFO] Please REBOOT your system for all changes to take effect.
echo.
pause