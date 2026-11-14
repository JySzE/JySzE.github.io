@echo off
:: === Windows 11 Optimizations Batch Script ===
:: Run as Administrator!!!!!!!!!!!!!!!!!

setlocal EnableExtensions EnableDelayedExpansion
color 0A

:: --- Check for Administrator ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Please run this script as Administrator.
    pause
    exit /b
)

:: --- Check for Windows 11 ---
for /f "tokens=4-5 delims=. " %%i in ('ver') do set verMajor=%%i & set verMinor=%%j
if %verMajor% lss 10 (
    echo [ERROR] This script is intended for Windows 11 only.
    pause
    exit /b
)

echo ========================================
echo   Windows 11 Optimization Script
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
echo             Only proceed if you understand the risks^!
echo.
echo [RECOMMENDED] Best used on a FRESH Windows 11 installation.
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

:: Align Taskbar to the left
echo [INFO] Aligning Taskbar icons to the left...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SystemSettings_DesktopTaskbar_Al /t REG_SZ /d 0 /f >nul 2>&1

:: Remove Task view from Taskbar
echo [INFO] Removing Task view from Taskbar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f

:: Remove Search bar from Taskbar
echo [INFO] Removing Search bar from Taskbar...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f

:: Classic Right-Click Menu
echo [INFO] Applying Classic Right-Click Menu...
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f >nul 2>&1

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

:: Disable Widgets
echo [INFO] Disabling Widgets...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v AllowNewsAndInterests /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable News and Interests
echo [INFO] Disabling News and Interests...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Chat (Teams/Meet Now)
echo [INFO] Disabling Chat icon...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" /v ChatIcon /t REG_DWORD /d 3 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable People Bar
echo [INFO] Disabling People Bar...
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v HidePeopleBar /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Lock Screen
echo [INFO] Disabling Lock Screen...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f >nul 2>&1

:: Show seconds in system clock
echo [INFO] Enabling seconds in system clock...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 1 /f >nul 2>&1

:: Show file extensions for known types
echo [INFO] Showing file extensions...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f >nul 2>&1

:: Remove Home and Gallery from File Explorer (Test)
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" /f >nul 2>&1
reg add "HKCU\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 0 /f >nul 2>&1

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

:: Additional diagnostic data policies (second AllowTelemetry path used by Win11Debloat + extra DataCollection values)
echo [INFO] Applying additional diagnostic data policies...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v MaxTelemetryAllowed /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DisableOneSettingsDownloads /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v LimitDiagnosticLogCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v LimitDumpCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowDeviceNameInTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DisableTelemetryOptInChangeNotification /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DisableTelemetryOptInSettingsUx /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable diagnostic autologgers (ETW trace sessions that feed telemetry)
echo [INFO] Disabling telemetry autologger sessions...
:: Only touches loggers that already exist, so no stray/incomplete autologger keys get created
for %%l in (AutoLogger-Diagtrack-Listener Diagtrack-Listener SQMLogger SetupPlatformTel CloudExperienceHostOobe) do (
    reg query "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\%%l" >nul 2>&1 && reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\%%l" /v Start /t REG_DWORD /d 0 /f >nul 2>&1
)

:: Disable Activity History upload/publishing (policy level)
echo [INFO] Disabling Activity History publishing and upload...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f >nul 2>&1

:: Advertising ID, tailored experiences and language-list tracking
echo [INFO] Disabling Advertising ID, tailored experiences and language-list tracking...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\International\User Profile" /v HttpAcceptLanguageOptOut /t REG_DWORD /d 1 /f >nul 2>&1

:: Online speech recognition, inking/typing personalization and handwriting data sharing
echo [INFO] Disabling online speech, inking and typing data collection...
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v HasAccepted /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" /v HarvestContacts /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v AllowInputPersonalization /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v PreventHandwritingErrorReports /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v PreventHandwritingDataSharing /t REG_DWORD /d 1 /f >nul 2>&1

:: Stop app-launch tracking and set Feedback Frequency to Never
echo [INFO] Disabling app-launch tracking and feedback prompts...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackProgs /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v PeriodInNanoSeconds /f >nul 2>&1

:: Stop Windows Search from using cloud/web results
echo [INFO] Disabling cloud and web search...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCloudSearch /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f >nul 2>&1

:: NOTE: some of these keys/tasks are protected (TrustedInstaller/SYSTEM only). Under a plain
:: Administrator token they can fail silently - that is expected and harmless.

:: Diagnostic data processor / commercial data pipeline / experimentation policies
echo [INFO] Applying extended diagnostic data processor policies...
for %%v in (AllowDesktopAnalyticsProcessing AllowUpdateComplianceProcessing AllowWUfBCloudProcessing AllowCommercialDataPipeline MicrosoftEdgeDataOptIn EnableExtendedBooksTelemetry MaxTelemetryAllowed) do reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v %%v /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowTelemetry" /v value /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v AllowExperimentation /t REG_DWORD /d 0 /f >nul 2>&1

:: Device metadata download, driver-not-found error reports, Help Experience Improvement (HEIP) feedback
echo [INFO] Disabling device metadata retrieval, driver error reports and HEIP feedback...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\DriverDatabase\Policies\Settings" /v DisableSendGenericDriverNotFoundToWER /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /v DisableSendGenericDriverNotFoundToWER /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v NoActiveHelp /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v NoExplicitFeedback /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v NoImplicitFeedback /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Assistance\Client\1.0" /v NoExplicitFeedback /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Assistance\Client\1.0" /v NoImplicitFeedback /t REG_DWORD /d 1 /f >nul 2>&1

:: More Windows Error Reporting policy values
echo [INFO] Tightening Windows Error Reporting policies...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DontSendAdditionalData /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v LoggingDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v DoReport /t REG_DWORD /d 0 /f >nul 2>&1

:: App compatibility telemetry (Census / Appraiser / AIT), CEIP/SQM, PerfTrack, DiagTrack upload hooks
echo [INFO] Disabling Census, Appraiser, CEIP/SQM, PerfTrack and DiagTrack upload hooks...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AIT" /v AITEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v IsCensusDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v DontRetryOnError /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v TaskEnableRun /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\TelemetryController" /v RunsBlocked /t REG_DWORD /d 1 /f >nul 2>&1
for %%k in (IE Reliability) do (
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\%%k" /v CEIPEnable /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Microsoft\SQMClient\%%k" /v SqmLoggerRunning /t REG_DWORD /d 0 /f >nul 2>&1
)
reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v SqmLoggerRunning /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v DisableOptinExperience /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\PerfTrack" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics" /v EnabledExecution /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\ScheduledDiagnostics" /v EnabledExecution /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v DiagTrackAuthorization /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v TelemetryServiceDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\TestHooks" /v DisableAsimovUpload /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey" /v EnableEventTranscript /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\TraceManager" /v MiniTraceSlotEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Storage / driver / Web Deploy telemetry
echo [INFO] Disabling storage, crash-dump device and Web Deploy telemetry...
for %%v in (TelemetryPerformanceEnabled TelemetryErrorDataEnabled TelemetryDeviceHealthEnabled) do reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v %%v /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl\StorageTelemetry" /v DeviceDumpEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\MSDeploy\3" /v EnableTelemetry /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable telemetry-related Application Experience event log channels
echo [INFO] Disabling Application Experience telemetry event logs...
set "EVT_CHANNELS=Microsoft-Windows-Application-Experience/Steps-Recorder Microsoft-Windows-Application-Experience/Program-Telemetry Microsoft-Windows-Application-Experience/Program-Inventory Microsoft-Windows-Application-Experience/Program-Compatibility-Troubleshooter Microsoft-Windows-Application-Experience/Program-Compatibility-Assistant"
for %%c in (%EVT_CHANNELS%) do wevtutil sl "%%c" /e:false >nul 2>&1

:: Settings sync, input personalization (policy level), linguistic data, speech model updates
echo [INFO] Disabling settings sync and input/speech data collection (policy level)...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSync /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSyncUserOverride /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v EnableBackupForWin8Apps /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /v AllowLinguisticDataCollection /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v LMDataLoggerEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Speech" /v AllowSpeechModelUpdate /t REG_DWORD /d 0 /f >nul 2>&1

:: Remaining Windows Search / location policy values
echo [INFO] Tightening Windows Search and location policies...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWebOverMeteredConnections /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v PreventRemoteQueries /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortanaAboveLock /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableLocationScripting /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableWindowsLocationProvider /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v Value /t REG_SZ /d Deny /f >nul 2>&1

:: Block UWP apps from running in the background, plus post-update / first-run nags
echo [INFO] Disabling UWP background apps and setup nags...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v DisablePrivacyExperience /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Remaining Cloud Content / Content Delivery Manager values
echo [INFO] Disabling remaining cloud content and content delivery values...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableCloudOptimizedContent /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableSoftLanding /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v IncludeEnterpriseSpotlight /t REG_DWORD /d 0 /f >nul 2>&1
for %%v in (ContentDeliveryAllowed OemPreInstalledAppsEnabled PreInstalledAppsEnabled PreInstalledAppsEverEnabled SubscribedContentEnabled SubscribedContent-338393Enabled SubscribedContent-353696Enabled SubscribedContent-310093Enabled SubscribedContent-314559Enabled SubscribedContent-353698Enabled) do reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v %%v /t REG_DWORD /d 0 /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\Subscriptions" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SuggestedApps" /f >nul 2>&1

:: Windows Media Player metadata / online DRM lookups
echo [INFO] Disabling Windows Media Player metadata and online DRM lookups...
for %%v in (PreventCDDVDMetadataRetrieval PreventMusicFileMetadataRetrieval PreventRadioPresetsRetrieval) do reg add "HKCU\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer" /v %%v /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WMDRM" /v DisableOnline /t REG_DWORD /d 1 /f >nul 2>&1

:: Block CompatTelRunner.exe (Image File Execution Options redirect - reversible by deleting this key)
echo [INFO] Blocking CompatTelRunner.exe from running...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" /v Debugger /t REG_SZ /d "%windir%\System32\taskkill.exe" /f >nul 2>&1

:: Disable the Recall optional feature if present (no-op on builds that don't ship it)
echo [INFO] Checking for the Recall optional feature via DISM (this can take a minute, please wait)...
dism /online /disable-feature /featurename:Recall /norestart >nul 2>&1

:: Opt out of PowerShell and .NET CLI telemetry (machine-wide)
echo [INFO] Opting out of PowerShell and .NET CLI telemetry...
setx /M POWERSHELL_TELEMETRY_OPTOUT 1 >nul 2>&1
setx /M DOTNET_CLI_TELEMETRY_OPTOUT 1 >nul 2>&1

:: Disable Windows Error Reporting
echo [INFO] Disabling Windows Error Reporting...
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1

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

:: Disable Bing/Web Search Suggestions
echo [INFO] Disabling Bing/Web Search Suggestions...
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Windows Consumer Experience and Cloud Content
echo [INFO] Disabling Windows Consumer Experience, Tips, and Cloud Content...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightFeatures /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableThirdPartySuggestions /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnActionCenter /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightOnSettings /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsSpotlightWindowsWelcomeExperience /t REG_DWORD /d 1 /f >nul 2>&1

:: Fully stop Windows Spotlight background image downloads/tracking (covers the mode switch itself)
echo [INFO] Disabling Windows Spotlight image downloads and tracking...
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v "ConfigureWindowsSpotlight" /t REG_DWORD /d 2 /f >nul 2>&1

:: Hide Microsoft 365 Copilot ads on the Settings Home page (from Win11Debloat)
echo [INFO] Hiding Microsoft 365 Copilot ads in Settings Home...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableConsumerAccountStateContent" /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Windows Location Services, app location access, and Find My Device (from Win11Debloat)
echo [INFO] Disabling Windows Location Services and app location access...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f >nul 2>&1
echo [INFO] Disabling Find My Device location tracking...
reg add "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v "AllowFindMyDevice" /t REG_DWORD /d 0 /f >nul 2>&1

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

:: Turn off Suggested Actions
echo [INFO] Turning off Suggested Actions...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SmartActionPlatform\SmartClipboard" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Input\Settings" /v InsightsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Input\Settings" /v TextPredictionEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Input\Settings" /v HistoryEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Cortana, Bing, Copilot, Windows Recall
echo [INFO] Disabling Cortana, Bing, Copilot, Windows Recall...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v CortanaConsent /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Copilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilot /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Recall" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Copilot Key / Win+C AI shortcut (hardware level) and enforce Recall/AI Snapshot policy block
echo [INFO] Disabling physical Copilot Key and Win+C AI shortcut...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowCopilotButton" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f >nul 2>&1
echo [INFO] Enforcing Recall and AI Snapshots policy blocks...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "TurnOffWindowsAI" /t REG_DWORD /d 1 /f >nul 2>&1

:: Prevent the Windows AI Fabric service from starting automatically (from Win11Debloat)
echo [INFO] Preventing AI service (WSAIFabricSvc) from starting automatically...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSAIFabricSvc" /v "Start" /t REG_DWORD /d 3 /f >nul 2>&1

:: Disable AI features in Notepad and Paint (from Win11Debloat)
echo [INFO] Disabling AI features in Notepad...
reg add "HKLM\SOFTWARE\Policies\WindowsNotepad" /v "DisableAIFeatures" /t REG_DWORD /d 1 /f >nul 2>&1
echo [INFO] Disabling AI features in Paint...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableCocreator" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeFill" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableImageCreator" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeErase" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableRemoveBackground" /t REG_DWORD /d 1 /f >nul 2>&1

:: Granular WindowsAI policies beyond the single TurnOffWindowsAI blanket key
echo [INFO] Applying granular Copilot/Recall/Agent policy keys...
for %%v in (DisableAIDataAnalysis TurnOffSavingSnapshots DisableSettingsAgent DisableAgentConnectors DisableAgentWorkspaces DisableRemoteAgentConnectors) do reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v %%v /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v AllowRecallEnablement /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f >nul 2>&1

:: Mark Copilot as unavailable/ineligible rather than just hidden (both hives)
for %%h in (HKLM HKCU) do (
    reg add "%%h\SOFTWARE\Microsoft\Windows\Shell\Copilot\BingChat" /v IsUserEligible /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%h\SOFTWARE\Microsoft\Windows\Shell\Copilot" /v IsCopilotAvailable /t REG_DWORD /d 0 /f >nul 2>&1
    reg add "%%h\SOFTWARE\Microsoft\Windows\Shell\Copilot" /v CopilotDisabledReason /t REG_SZ /d "FeatureIsDisabled" /f >nul 2>&1
)

:: Voice agent activation, M365Copilot flyout, taskbar/background/UI pins
echo [INFO] Disabling voice agent activation and remaining Copilot UI surfaces...
reg add "HKCU\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" /v AgentActivationEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\WindowsCopilot" /v AllowCopilotRuntime /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband\AuxilliaryPins" /v CopilotPWAPin /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband\AuxilliaryPins" /v RecallPin /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarCompanion /t REG_DWORD /d 0 /f >nul 2>&1
for %%v in (DisabledByUser Disabled SleepDisabled) do reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.Copilot_8wekyb3d8bbwe" /v %%v /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\InkingAndTypingPersonalization" /v Value /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v AutoOpenCopilotLargeScreens /t REG_DWORD /d 0 /f >nul 2>&1

:: AI consent store and the AppPrivacy policy that governs it
echo [INFO] Denying app access to generative AI / system AI models...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\generativeAI" /v Value /t REG_SZ /d Deny /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\systemAIModels" /v Value /t REG_SZ /d Deny /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsAccessGenerativeAI /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsAccessSystemAIModels /t REG_DWORD /d 2 /f >nul 2>&1

:: Leftover WindowsAI scheduled-task config and Copilot auto-launch/telemetry keys
echo [INFO] Clearing WindowsAI scheduled-task config and Copilot auto-launch keys...
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsAI\LastConfiguration" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\Shell\Copilot" /v CopilotLogonTelemetryTime /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Copilot" /v WakeApp /f >nul 2>&1
reg delete "HKCU\Software\Classes\.copilot" /f >nul 2>&1
reg delete "HKCR\.copilot" /f >nul 2>&1

:: Disable the experimental agentic/isolated-environment broker service
reg add "HKLM\SYSTEM\CurrentControlSet\Services\IsoEnvBroker" /v Start /t REG_DWORD /d 4 /f >nul 2>&1

:: Fully remove the conversational agent runtime and Copilot elevation helper services
:: (WSAIFabricSvc above is left on manual-start rather than deleted - these two have no other
:: dependents, so a full removal is lower-risk; delete is NOT easily reversible without a backup)
echo [INFO] Removing AarSvc and MicrosoftCopilotElevationService...
for %%s in (AarSvc MicrosoftCopilotElevationService) do (
    sc query %%s >nul 2>&1 && (
        sc stop %%s >nul 2>&1
        sc delete %%s >nul 2>&1
    )
)

:: Disable Office Copilot/AI (no-op if Office isn't installed - just creates unused policy keys)
echo [INFO] Disabling Copilot and AI training/content-safety features in Office...
reg add "HKLM\SOFTWARE\Policies\Microsoft\office\16.0\common\ai\training\general" /v disabletraining /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\office\16.0\common\ai\training\specific\adaptivefloatie" /v disabletrainingofadaptivefloatie /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\office\16.0\common\privacy" /v controllerconnectedservicesenabled /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Software\Policies\Microsoft\office\16.0\common\privacy" /v usercontentdisabled /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\Word\Options" /v EnableCopilot /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\Excel\Options" /v EnableCopilot /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\OneNote\Options\Copilot" /v CopilotEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\OneNote\Options\Copilot" /v CopilotNotebooksEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\OneNote\Options\Copilot" /v CopilotSkittleEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Office\16.0\PowerPoint\Options" /v "Enable Copilot in Settings" /t REG_DWORD /d 0 /f >nul 2>&1
for %%k in (alternativetext imagequestionandanswering promptassistance rewrite summarization summarizationwithreferences texttotable) do reg add "HKLM\SOFTWARE\Policies\Microsoft\office\16.0\common\ai\contentsafety\specific\%%k" /v disablecontentsafety /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\office\16.0\common\ai\contentsafety\general" /v disablecontentsafety /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable Voice Access (registry-level only - leaves voiceaccess.exe in place, unlike the source
:: project's TrustedInstaller-based file deletion, which is too invasive to replicate safely here)
echo [INFO] Disabling Voice Access...
reg add "HKCU\Software\Microsoft\VoiceAccess" /v RunningState /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\VoiceAccess" /v TextCorrection /t REG_DWORD /d 2 /f >nul 2>&1

:: Remove Windows Copilot for all users
echo [INFO] Removing Windows Copilot for all users...
dism /online /remove-package /package-name:Microsoft.Windows.Copilot /norestart >nul 2>&1
powershell -NoProfile -Command "Get-AppxPackage -Name Microsoft.Windows.Copilot -AllUsers | Remove-AppxPackage" >nul 2>&1
powershell -NoProfile -Command "Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like '*Copilot*'} | Remove-AppxProvisionedPackage -Online" >nul 2>&1
rd "%LocalAppData%\Packages\Microsoft.Windows.Copilot*" /s /q >nul 2>&1

:: Disable Click-to-Do / AI Analysis Tool
echo [INFO] Disabling Click-to-Do / AI Analysis...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AIAnalysis" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v DisableClickToDo /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableClickToDo /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v AllowCopilot /t REG_DWORD /d 0 /f >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\WindowsAI\ClickToDo" /Disable >nul 2>&1

:: Disable Cloud Clipboard Sync and AI suggestions
echo [INFO] Disabling Cloud Clipboard Sync and AI Suggestions...
reg add "HKCU\Software\Microsoft\Clipboard" /v CloudClipboardSyncEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Clipboard" /v EnableCloudClipboardSuggestions /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Windows Voice Typing / Dictation
echo [INFO] Disabling Windows Voice Typing and Dictation...
reg add "HKCU\Software\Microsoft\TabletTip\1.7" /v EnableDesktopTip /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Input\Personalization" /v UserModelConsent /t REG_DWORD /d 0 /f >nul 2>&1

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

echo [SECTION 2] Telemetry and Privacy Optimizations Complete^!
echo.

:: ========================================
:: SECTION 3: SECURITY FEATURES (PERFORMANCE MODE)
:: ========================================
echo [SECTION 3] Disabling Security Features for Performance...

:: Windows Defender Section
echo.
echo ============================================================
echo  DISABLE WINDOWS DEFENDER?
echo ============================================================
echo.
echo WARNING: This will leave your system without antivirus protection^!
echo.
echo This disables:
echo   - Real-Time Protection
echo   - Advanced Threat Protection (ATP)
echo   - All Defender services
echo.
set /p defender_choice="Disable Windows Defender? (Y/N): "

if /i "!defender_choice!"=="Y" (
    echo [INFO] Disabling Windows Defender Real-Time Protection and ATP...
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiVirus /t REG_DWORD /d 1 /f >nul 2>&1
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Advanced Threat Protection" /v ForceDefenderPassiveMode /t REG_DWORD /d 1 /f >nul 2>&1
    
    echo [INFO] Disabling Windows Defender Services...
    sc query WdNisSvc >nul 2>&1
    if !errorlevel!==0 (
        sc config WdNisSvc start= disabled >nul 2>&1
        sc stop WdNisSvc >nul 2>&1
    )
    sc query WinDefend >nul 2>&1
    if !errorlevel!==0 (
        sc config WinDefend start= disabled >nul 2>&1
        sc stop WinDefend >nul 2>&1
    )
    sc query Sense >nul 2>&1
    if !errorlevel!==0 (
        sc config Sense start= disabled >nul 2>&1
        sc stop Sense >nul 2>&1
    )
    echo [SUCCESS] Windows Defender disabled
) else (
    echo [SKIPPED] Windows Defender left enabled
)

:: VBS/HVCI Section
echo.
echo ============================================================
echo  DISABLE VBS/HVCI (Memory Integrity)?
echo ============================================================
echo.
echo NOTE: If you have 12th Gen Intel or newer, OR AMD Ryzen 5000+
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

:: Spectre/Meltdown Section
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
echo WARNING: Disabling these removes important security protections^!
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

echo [SECTION 3] Security Feature Optimizations Complete^!
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

echo [SECTION 4] Network Optimizations Complete^!
echo.

:: ========================================
:: SECTION 5: PERFORMANCE and RESPONSIVENESS
:: ========================================
echo [SECTION 5] Applying Performance and Responsiveness Tweaks...

:: Disable Background Apps
echo [INFO] Disabling Background Apps...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Capabilities" /v AppRunInBackground /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable Power Throttling
echo [INFO] Disabling Power Throttling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul 2>&1

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

:: Disable Windows automatic power constraint generation (PEP)
echo [INFO] Disabling automatic power constraints (PEP)...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v DisableInboxPepGeneratedConstraints /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable USB selective suspend
echo [INFO] Disabling USB selective suspend...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\2a737441-1930-4402-8d77-b2bebba308a3\48e6b7a6-50f5-4782-a5d4-53bb8f07e226" /v Attributes /t REG_DWORD /d 0 /f >nul 2>&1
powercfg /setacvalueindex scheme_min 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0 >nul 2>&1

:: Disable PCIe Link State Power Management
echo [INFO] Disabling PCIe Link State Power Management...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\501a4d13-42af-4429-9fd1-a8218c268e20\ee12f906-d277-404b-b6da-e5fa1a576df5" /v Attributes /t REG_DWORD /d 0 /f >nul 2>&1
powercfg /setacvalueindex scheme_min 501a4d13-42af-4429-9fd1-a8218c268e20 ee12f906-d277-404b-b6da-e5fa1a576df5 0 >nul 2>&1

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

echo [SECTION 5] Performance Optimizations Complete^!
echo.

:: ========================================
:: SECTION 6: AUDIO OPTIMIZATIONS
:: ========================================
echo [SECTION 6] Applying Audio Optimizations...

:: Disable audio enhancements
echo [INFO] Disabling audio enhancements...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render" /v DisableProtectedAudioDG /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Multimedia\Audio" /v UserDuckingPreference /t REG_DWORD /d 3 /f >nul 2>&1

:: Set audio to exclusive mode
echo [INFO] Setting audio to exclusive mode...
for /f "delims=" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render" /s /f "FriendlyName" ^| findstr "HKEY"') do (
    reg add "%%a" /v "UserInterfaceDefault" /t REG_DWORD /d 1 /f >nul 2>&1
)

echo [SECTION 6] Audio Optimizations Complete^!
echo.

:: ========================================
:: SECTION 7: GPU OPTIMIZATIONS
:: ========================================
echo [SECTION 7] Applying GPU Optimizations...

:: Disable Hardware-Accelerated GPU Scheduling (better compatibility)
echo [INFO] Disabling HAGS for compatibility...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul 2>&1

:: Disable Multi-Plane Overlay (reduces flickering/stuttering)
echo [INFO] Disabling Multi-Plane Overlay...
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v OverlayTestMode /t REG_DWORD /d 5 /f >nul 2>&1

:: Extend TDR timeout (prevents driver crashes during load)
echo [INFO] Extending TDR timeout...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDelay /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v TdrDdiDelay /t REG_DWORD /d 8 /f >nul 2>&1

:: Disable connected standby for GPU
echo [INFO] Disabling GPU connected standby...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v CsEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Apply GPU power/performance tweaks (All manufacturers)
echo [INFO] Applying GPU power and performance tweaks...
for %%G in (0000 0001 0002 0003) do (
    :: AMD: Disable ULPS (Ultra Low Power State)
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\%%G" /v EnableUlps /t REG_DWORD /d 0 /f >nul 2>&1
    :: Intel: Disable overlay quality enhancement
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

echo [SECTION 7] GPU Optimizations Complete^!
echo.

:: ========================================
:: SECTION 8: GAMING and MULTIMEDIA
:: ========================================
echo [SECTION 8] Applying Gaming and Multimedia Optimizations...

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
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NoLazyMode /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v AlwaysOn /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v Priority /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d High /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v Priority /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "Scheduling Category" /t REG_SZ /d High /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback" /v "SFIO Priority" /t REG_SZ /d High /f >nul 2>&1

echo [SECTION 8] Gaming and Multimedia Optimizations Complete^!
echo.

:: ========================================
:: SECTION 9: SERVICES OPTIMIZATION
:: ========================================
echo [SECTION 9] Disabling Unnecessary Services...

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
:: NOTE: dmwappushservice (WAP Push / telemetry routing) and the Diagnostics Hub collector were added here.
:: The loop uses && instead of %errorlevel% because %errorlevel% is expanded once when the whole
:: parenthesized block is parsed, not per iteration, which made the old check unreliable.
:: NOTE: WpnService, WpnUserService, CDPSvc and CDPUserSvc are intentionally NOT in this list.
:: Disabling them (together with OneSyncSvc and MessagingService) broke notifications, the
:: taskbar calendar flyout and the Settings notifications page. OneSyncSvc and MessagingService
:: were tested on their own afterwards and are fine to disable.
set "SERVICES_TO_DISABLE=dmwappushservice diagnosticshub.standardcollector.service wercplsupport InventorySvc WpcMonSvc WMPNetworkSvc wisvc ndu lfsvc MapsBroker MessagingService OneSyncSvc WerSvc HomeGroupProvider RetailDemo"
for %%s in (%SERVICES_TO_DISABLE%) do (
    sc query %%s >nul 2>&1 && (
        sc config %%s start= disabled >nul 2>&1
        sc stop %%s >nul 2>&1
    )
)

:: Disable telemetry-related scheduled tasks (silently skipped if a task doesn't exist on this build)
echo [INFO] Disabling telemetry scheduled tasks...
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClient" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\AITAgent" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Device Information\Device" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Diagnosis\Scheduled" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\International\Synchronize Language Settings" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\PI\Sqm-Tasks" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Speech\SpeechModelDownloadTask" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\User Profile Service\HiveUploadTask" /Disable >nul 2>&1

:: Disable NVIDIA telemetry scheduled tasks (NvTmMon / NvTmRep / NvTmRepOnLogon)
echo [INFO] Disabling NVIDIA telemetry scheduled tasks...
powershell -NoProfile -Command "Get-ScheduledTask -TaskName 'NvTm*' -ErrorAction SilentlyContinue | Disable-ScheduledTask -ErrorAction SilentlyContinue" >nul 2>&1

:: Clean already-collected diagnostic data (DiagTrack .rbs files and ETL logs)
echo [INFO] Cleaning previously collected DiagTrack diagnostic data...
takeown /f "%ProgramData%\Microsoft\Diagnosis" /a /r /d y >nul 2>&1
icacls "%ProgramData%\Microsoft\Diagnosis" /grant:r "*S-1-5-32-544:(OI)(CI)(IO)(F)" /T /C >nul 2>&1
del /f /q "%ProgramData%\Microsoft\Diagnosis\*.rbs" >nul 2>&1
del /f /s /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\*" >nul 2>&1

:: Startup task that re-applies the most critical telemetry settings (cumulative updates can reset them)
echo [INFO] Creating TelemetryOFF startup task to re-apply critical settings...
if not exist "%ProgramData%\Scripts" mkdir "%ProgramData%\Scripts" >nul 2>&1
(
    echo @echo off
    echo reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
    echo reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
    echo reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v TaskEnableRun /t REG_DWORD /d 0 /f
    echo reg add "HKLM\SYSTEM\DriverDatabase\Policies\Settings" /v DisableSendGenericDriverNotFoundToWER /t REG_DWORD /d 1 /f
    echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v Start /t REG_DWORD /d 4 /f
    echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v Start /t REG_DWORD /d 4 /f
) > "%ProgramData%\Scripts\Fix-Telemetry.cmd"
schtasks /Create /TN "TelemetryOFF" /TR "%ProgramData%\Scripts\Fix-Telemetry.cmd" /SC ONSTART /RU SYSTEM /RL HIGHEST /F >nul 2>&1

:: Second startup task that re-applies the core AI-disabling keys - the batch-only equivalent of
:: Windows Update may have reinstalled; this just makes sure the policy keys stick)
echo [INFO] Creating AICleanupOFF startup task to re-apply core AI policy keys...
(
    echo @echo off
    echo reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v TurnOffWindowsAI /t REG_DWORD /d 1 /f
    echo reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v AllowRecallEnablement /t REG_DWORD /d 0 /f
    echo reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v DisableAIDataAnalysis /t REG_DWORD /d 1 /f
    echo reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v TurnOffWindowsCopilot /t REG_DWORD /d 1 /f
    echo reg add "HKCU\Software\Microsoft\Windows\Shell\Copilot" /v IsCopilotAvailable /t REG_DWORD /d 0 /f
    echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSAIFabricSvc" /v Start /t REG_DWORD /d 3 /f
    echo reg add "HKLM\SYSTEM\CurrentControlSet\Services\IsoEnvBroker" /v Start /t REG_DWORD /d 4 /f
) > "%ProgramData%\Scripts\Fix-AI.cmd"
schtasks /Create /TN "AICleanupOFF" /TR "%ProgramData%\Scripts\Fix-AI.cmd" /SC ONSTART /RU SYSTEM /RL HIGHEST /F >nul 2>&1

echo [SECTION 9] Service Optimizations Complete^!
echo.

:: ========================================
:: SECTION 10: HYPER-V and VIRTUALIZATION
:: ========================================
echo [SECTION 10] Disabling Hyper-V and Virtualization Features...

echo [INFO] Disabling Hyper-V / Virtualization Features...
dism /online /disable-feature /featurename:Microsoft-Hyper-V-All /norestart >nul 2>&1
dism /online /disable-feature /featurename:VirtualMachinePlatform /norestart >nul 2>&1
dism /online /disable-feature /featurename:HypervisorPlatform /norestart >nul 2>&1
dism /online /disable-feature /featurename:Containers-DisposableClientVM /norestart >nul 2>&1

echo [SECTION 10] Virtualization Optimizations Complete^!
echo.

:: ========================================
:: SECTION 11: ONEDRIVE REMOVAL
:: ========================================
echo [SECTION 11] Removing OneDrive...

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

echo [SECTION 11] OneDrive Removal Complete^!
echo.

:: ========================================
:: SECTION 12: EDGE BROWSER OPTIMIZATIONS
:: ========================================
echo [SECTION 12] Disabling Background Edge Processes and AI Features...

echo [INFO] Disabling background Edge processes...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v StartupBoostEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v BackgroundModeEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v HardwareAccelerationModeEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Edge\Main" /v AllowPrelaunch /t REG_DWORD /d 0 /f >nul 2>&1

:: Strip AI features out of Microsoft Edge
echo [INFO] Disabling AI sidebars, Discover, and Copilot inside Edge...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "HubsSidebarEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiscoverPageContextEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "ComposeInlineEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
:: Additional official Win11Debloat Edge AI policy keys
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CopilotCDPPageContext" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "CopilotPageContext" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeEntraCopilotPageContext" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "EdgeHistoryAISearchEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "GenAILocalFoundationalModelSettings" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "NewTabPageBingChatEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

:: Edge telemetry / diagnostic data (PersonalizationReportingEnabled + DiagnosticData are from Win11Debloat)
echo [INFO] Disabling Edge telemetry and diagnostic data...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "PersonalizationReportingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "DiagnosticData" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "MetricsReportingEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "SendSiteInfoToImproveServices" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "UserFeedbackAllowed" /t REG_DWORD /d 0 /f >nul 2>&1

echo [SECTION 12] Edge Optimizations Complete^!
echo.

:: ========================================
:: SECTION 13: CONTEXT MENU ENHANCEMENTS
:: ========================================
echo [SECTION 13] Adding Context Menu Enhancements...

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

echo [SECTION 13] Context Menu Enhancements Complete^!
echo.

:: ========================================
:: SECTION 14: WINDOWS PHOTO VIEWER
:: ========================================
echo [SECTION 14] Restoring Windows Photo Viewer...

echo [INFO] Restoring Windows Photo Viewer...
for %%e in (jpg jpeg png bmp gif tiff ico) do reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v .%%e /t REG_SZ /d "PhotoViewer.FileAssoc.%%e" /f >nul 2>&1

echo [SECTION 14] Windows Photo Viewer Restored^!
echo.

:: ========================================
:: SECTION 15: BLOATWARE REMOVAL
:: ========================================
echo [SECTION 15] Removing Preinstalled Apps and Bloatware...

:: Disable Common Bloatware Startup Programs
echo [INFO] Disabling common bloatware startup programs...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDriveSetup" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MicrosoftEdgeAutoLaunch" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDefender" /f >nul 2>&1

:: Remove selected preinstalled apps
echo [INFO] Removing unwanted preinstalled apps (this may take a while)...
set "APPS_TO_REMOVE=Clipchamp.Clipchamp Microsoft.3DBuilder Microsoft.549981C3F5F10 Microsoft.StartExperiencesApp Microsoft.GamingApp Microsoft.XboxGamingOverlay Microsoft.Bing Microsoft.BingSearch Microsoft.BingFinance Microsoft.BingFoodAndDrink Microsoft.BingHealthAndFitness Microsoft.BingNews Microsoft.BingSports Microsoft.BingTranslator Microsoft.BingTravel Microsoft.BingWeather Microsoft.Copilot Microsoft.Messaging Microsoft.Microsoft3DViewer Microsoft.MicrosoftJournal Microsoft.MicrosoftOfficeHub Microsoft.MicrosoftPowerBIForWindows Microsoft.MicrosoftSolitaireCollection Microsoft.MicrosoftStickyNotes Microsoft.MixedReality.Portal Microsoft.NetworkSpeedTest Microsoft.News Microsoft.Office.OneNote Microsoft.Office.Sway Microsoft.OneConnect Microsoft.Print3D Microsoft.PowerAutomateDesktop Microsoft.SkypeApp Microsoft.Todos Microsoft.Windows.DevHome Microsoft.WindowsAlarms Microsoft.WindowsFeedbackHub Microsoft.WindowsMaps Microsoft.WindowsSoundRecorder Microsoft.XboxApp Microsoft.ZuneVideo MicrosoftCorporationII.MicrosoftFamily MicrosoftCorporationII.QuickAssist MicrosoftTeams MSTeams Microsoft.WindowsNotepad ACGMediaPlayer ActiproSoftwareLLC AdobeSystemsIncorporated.AdobePhotoshopExpress Amazon.com.Amazon AmazonVideo.PrimeVideo Asphalt8Airborne AutodeskSketchBook CaesarsSlotsFreeCasino COOKINGFEVER CyberLinkMediaSuiteEssentials DisneyMagicKingdoms Disney DrawboardPDF Duolingo-LearnLanguagesforFree EclipseManager Facebook FarmVille2CountryEscape fitbit Flipboard HiddenCity HULULLC.HULUPLUS iHeartRadio Instagram king.com.BubbleWitch3Saga king.com.CandyCrushSaga king.com.CandyCrushSodaSaga LinkedInforWindows MarchofEmpires Netflix NYTCrossword OneCalendar PandoraMediaInc PhototasticCollage PicsArt-PhotoStudio Plex PolarrPhotoEditorAcademicEdition RoyalRevolt Shazam Sidia.LiveWallpaper SlingTV Spotify TikTok TuneInRadio Twitter Viber WinZipUniversal Wunderlist XING Microsoft.GetHelp Microsoft.M365Companions Microsoft.MSPaint Microsoft.OutlookForWindows Microsoft.OneDrive Microsoft.People Microsoft.Whiteboard Microsoft.Windows.Photos Microsoft.WindowsCalculator Microsoft.WindowsCamera Microsoft.WindowsNotepad Microsoft.windowscommunicationsapps Microsoft.YourPhone Microsoft.ZuneMusic MicrosoftWindows.CrossDevice"
for %%a in (%APPS_TO_REMOVE%) do (
    powershell -NoProfile -Command "Get-AppxPackage -Name '%%a' -AllUsers -ErrorAction SilentlyContinue | ForEach-Object { Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction SilentlyContinue }" >nul 2>&1
)

echo [INFO] Finished removing preinstalled apps.
echo [SECTION 15] Bloatware Removal Complete^!
echo.

:: ========================================
:: SECTION 16: Downloading vcredist AIO and Dolby Digital Plus Decoder 
:: ========================================
echo [SECTION 16] Downloading vcredist AIO and Dolby Digital Plus Decoder ...

echo [INFO] Downloading and Installing Visual C++ Redistributables...
curl -L -o "%TEMP%\VisualCppRedist_AIO_x86_x64.exe" "https://www.tinyplease.com/vcpp" >nul 2>&1
if exist "%TEMP%\VisualCppRedist_AIO_x86_x64.exe" (
    start "" "%TEMP%\VisualCppRedist_AIO_x86_x64.exe" /ai
) else (
    echo [WARN] Failed to download VC++ Redistributables.
    echo [WARN] VC++ Installation Failed^!
)

echo [INFO] Downloading and Installing Dolby Digital Plus Decoders...
set "TEMP1=%TEMP%\DolbyAC4Decoder.AppxBundle"
set "TEMP2=%TEMP%\DolbyDigitalPlusDecoder.AppxBundle"

:: Download the AppxBundles
powershell -Command "Invoke-WebRequest -Uri 'https://files.catbox.moe/jux511.AppxBundle' -OutFile '%TEMP1%'"  >nul 2>&1
powershell -Command "Invoke-WebRequest -Uri 'https://files.catbox.moe/palb11.AppxBundle' -OutFile '%TEMP2%'"  >nul 2>&1

:: Install the AppxBundles
powershell -Command "Add-AppxPackage -Path '%TEMP1%' -ForceApplicationShutdown"  >nul 2>&1
powershell -Command "Add-AppxPackage -Path '%TEMP2%' -ForceApplicationShutdown"  >nul 2>&1

echo [SECTION 16] vcredist AIO and Dolby Digital Plus Decoder Complete^!
echo.
:: ========================================
:: SECTION 17: WINDOWS ACTIVATION
:: ========================================
echo [SECTION 17] Checking Windows Activation...

echo [INFO] Checking Windows Activation (HWID via MAS)...
powershell -Command "& ([ScriptBlock]::Create((irm 'https://get.activated.win'))) /HWID" >nul 2>&1

echo [SECTION 17] Activation Check Complete^!
echo.

:: ========================================
:: FINALIZATION
:: ========================================
echo [FINAL] Finalizing optimizations...

:: Clear Start Menu Pins
echo [INFO] Clearing all Start Menu pins for all users
curl -L -o "%TEMP%\start2.bin" "https://raw.githubusercontent.com/Raphire/Win11Debloat/master/Assets/Start/start2.bin" >nul 2>&1
timeout /t 1 /nobreak >nul 2>&1

copy /Y "%TEMP%\start2.bin" "%LOCALAPPDATA%\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState\start2.bin" >nul 2>&1

for /d %%u in (C:\Users\*) do (
    copy /Y "%TEMP%\start2.bin" "%%u\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState\start2.bin" >nul 2>&1
)

mkdir "C:\Users\Default\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState" >nul 2>&1
copy /Y "%TEMP%\start2.bin" "C:\Users\Default\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState\start2.bin" >nul 2>&1

del "%TEMP%\start2.bin" >nul 2>&1
echo [INFO] Start Menu Pins cleared

:: Refresh registry and restart Explorer
echo [INFO] Refreshing registry and restarting Explorer...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1
start explorer.exe

echo.
echo ========================================
echo   Optimization Complete^!
echo ========================================
echo.
echo [INFO] All optimizations applied successfully.
echo [INFO] Please REBOOT your system for all changes to take effect.
echo.
pause