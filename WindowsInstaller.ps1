##
 # Windows Build Automation
 # Built by @Dean Reid
 #
 # Class: WindowsInstaller.ps1
 #  
 # Class Information:
 #
 # Class checks if software installed is installed then runs the installation for each program noted in install-list
 # 
 # Program Version: 1.0
 # Code Version: 1.0
 # 
 # Updates: 
 # 15/03/2023 - Initial Code Development
 ###

#Requires -RunAsAdministrator
Set-ExecutionPolicy Bypass -Scope Process -Force
# Checks Execution Policy and if restricted asks user to change
$policy = Get-ExecutionPolicy
if ($policy -eq "Restricted") {
    $response = Read-Host "The execution policy is set to Restricted. Do you want to change it? (Y/N)"
    if ($response -eq "Y") {
		
		
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
    }
}

# Check if Chocolatey is installed and then install if not present
Write-Host "Checking for Chocolatey"
if (!(Test-Path -Path "$env:ProgramData\Chocolatey")) {
    Write-Host "Chocolatey not found, installing"
    Invoke-Expression((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else {
    Write-Host "Chocolatey found..."
	Write-Host "Installing Program List"
}

# Install Applications
Get-Content ".\install-list.txt" | ForEach-Object { ($_ -split "\r\n")[0] } | ForEach-Object {
    choco install $_ /y
}
