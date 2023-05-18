$AppsList = "Microsoft.BingFinance","Microsoft.XboxApp","Microsoft.BingSports","Microsoft.Getstarted","Microsoft.3DBuilder","Microsoft.BingWeather","Microsoft.Microsoft3DViewer",
"Microsoft.XboxGameOverlay","Microsoft.Xbox.TCUI","Microsoft.SkypeApp","Microsoft.ScreenSketch","Microsoft.Print3D",
"Microsoft.MixedReality.Portal","Microsoft.XboxGamingOverlay","Microsoft.XboxIdentityProvider","Microsoft.XboxSpeechToTextOverlay","Microsoft.YourPhone","Microsoft.ZuneMusic",
"Microsoft.ZuneVideo","Microsoft.WindowsCamera","Microsoft.Wallet","Microsoft.OneConnect","Microsoft.Messaging","PandoraMediaInc.29680B314EFC2""AdobeSystemIncorporated.AdobePhotoshop",
"D5EA27B7.Duolingo- LearnLanguagesforFree","Microsoft.BingNews","Microsoft.Office.Sway","Microsoft.Advertising.Xaml","Microsoft.Services.Store.Engagement", "Microsoft.WindowsFeedbackHub", "Microsoft.GetHelp", "Microsoft.WindowsStore", "Microsoft.Office.OneNote", "Microsoft.MicrosoftOfficeHub", "Microsoft.OutlookForWindows", "Microsoft.People", "Microsoft.MicrosoftSolitaireCollection" 

ForEach ($App in $AppsList)
{
$PackageFullName = (Get-AppxPackage $App).PackageFullName
$ProPackageFullName = (Get-AppxProvisionedPackage -online | where {$_.Displayname -eq $App}).PackageName
write-host $PackageFullName
Write-Host $ProPackageFullName
if ($PackageFullName)
{
Write-Host "Removing Package: $App"
remove-AppxPackage -package $PackageFullName
}
else
{
Write-Host "Unable to find package: $App"
}
if ($ProPackageFullName)
{
Write-Host "Removing Provisioned Package: $ProPackageFullName"
Remove-AppxProvisionedPackage -online -packagename $ProPackageFullName
}
else
{
Write-Host "Unable to find provisioned package: $App"
}
}