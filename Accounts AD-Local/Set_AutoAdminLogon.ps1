<#
The sample scripts are not supported under any Microsoft standard support 
program or service. The sample scripts are provided AS IS without warranty  
of any kind. Microsoft further disclaims all implied warranties including,  
without limitation, any implied warranties of merchantability or of fitness for 
a particular purpose. The entire risk arising out of the use or performance of  
the sample scripts and documentation remains with you. In no event shall 
Microsoft, its authors, or anyone else involved in the creation, production, or 
delivery of the scripts be liable for any damages whatsoever (including, 
without limitation, damages for loss of business profits, business interruption, 
loss of business information, or other pecuniary loss) arising out of the use 
of or inability to use the sample scripts or documentation, even if Microsoft 
has been advised of the possibility of such damages.
#> 

#Run script with adminsitrator
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

#Get user password 
$SecurePassword= read-host -Prompt "Please enter current user password" -AsSecureString
$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword));
$username = whoami
#Get default domain or computer name
$defaultdomain = ($username -split "\\")[0]
#Get current user name
$defaultuser = ($env:USERPROFILE -split "\\")[2]
#Change registry key values
$path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
New-ItemProperty -Path $path -name "AutoAdminLogon"  -PropertyType string  -ErrorAction SilentlyContinue
Set-ItemProperty -path $path -name "AutoAdminLogon" -Value 1 
New-ItemProperty -Path $path -name "DefaultDomainName" -PropertyType string -ErrorAction SilentlyContinue
Set-ItemProperty -Path $path -name "DefaultDomainName" -Value $defaultdomain
New-ItemProperty -Path $path -name "DefaultuserName"  -PropertyType string  -ErrorAction SilentlyContinue
Set-ItemProperty -Path $path -name "DefaultuserName" -Value   $defaultuser
New-ItemProperty -Path $path -name "DefaultPassword"  -PropertyType string  -ErrorAction SilentlyContinue
Set-ItemProperty -Path $path -name "DefaultPassword" -Value   $password
Write-Host "Set automatically login successfully when system starts up."

cmd /c pause