# Lynx Opener - Windows Installation Script
$HostName = "com.lynx.opener"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ProjectDir = (Get-Item $ScriptDir).Parent.FullName
$PythonScript = Join-Path $ProjectDir "host\lynx_opener.bat"

Write-Host "=== Lynx Opener Windows Installation ===" -ForegroundColor Cyan

# 1. Get Extension ID
$ExtId = Read-Host "Please enter your Chrome/Edge Extension ID (leave empty to skip Chrome installation)"

# 2. Setup Chrome
if ($ExtId) {
    $ManifestPath = Join-Path $ProjectDir "host\windows\$HostName.json"
    $ManifestContent = Get-Content (Join-Path $ProjectDir "host\windows\com.lynx.opener.json")
    $ManifestContent = $ManifestContent.Replace("HOST_PATH", $PythonScript.Replace("\", "\\"))
    $ManifestContent = $ManifestContent.Replace("EXTENSION_ID", $ExtId)
    $ManifestContent | Set-Content $ManifestPath
    
    $RegPath = "HKCU:\Software\Google\Chrome\NativeMessagingHosts\$HostName"
    if (!(Test-Path $RegPath)) { New-Item -Path $RegPath -Force }
    Set-ItemProperty -Path $RegPath -Name "(Default)" -Value $ManifestPath
    
    # Edge support
    $EdgeRegPath = "HKCU:\Software\Microsoft\Edge\NativeMessagingHosts\$HostName"
    if (!(Test-Path $EdgeRegPath)) { New-Item -Path $EdgeRegPath -Force }
    Set-ItemProperty -Path $EdgeRegPath -Name "(Default)" -Value $ManifestPath

    Write-Host "Installed for Chrome and Edge." -ForegroundColor Green
}

# 3. Setup Firefox
Write-Host "Installing for Firefox..."
$FirefoxManifestPath = Join-Path $ProjectDir "host\windows\${HostName}_firefox.json"
$FirefoxManifestContent = Get-Content (Join-Path $ProjectDir "host\windows\com.lynx.opener_firefox.json")
$FirefoxManifestContent = $FirefoxManifestContent.Replace("HOST_PATH", $PythonScript.Replace("\", "\\"))
$FirefoxManifestContent | Set-Content $FirefoxManifestPath

$FirefoxRegPath = "HKCU:\Software\Mozilla\NativeMessagingHosts\$HostName"
if (!(Test-Path $FirefoxRegPath)) { New-Item -Path $FirefoxRegPath -Force }
Set-ItemProperty -Path $FirefoxRegPath -Name "(Default)" -Value $FirefoxManifestPath

Write-Host "Installed for Firefox." -ForegroundColor Green

Write-Host "=== Installation Complete ===" -ForegroundColor Cyan
Write-Host "Note: Ensure 'lynx' is installed and in your PATH."
