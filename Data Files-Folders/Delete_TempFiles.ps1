<#
The sample scripts are provided AS IS without warranty  
of any kind. 
#>

#requires -Version 3
Function Clear-OSCTempFile
{
    #This function is used to delete temp files such as Internet temp file in windows 8 
    #Get all items with ".tmp" in the $env:TEMP path 
    $TempFiles =Get-ChildItem -Path $env:TEMP -Recurse | Where-Object {$_.Extension -contains ".tmp" } 
    #Call the function to delete them
    DeleteTemp $TempFiles
    #Get all items with ".tmp" in Temporary Internet Files 
    $InternetTempPath = "C:\Users\$env:USERNAME\AppData\Local\Microsoft\Windows\Temporary Internet Files"
    $InternetTmpFiles= Get-ChildItem -Path  $InternetTempPath -Recurse |Where-Object {$_.Extension -contains ".tmp"}
    #Call the function to delete them
    DeleteTemp $InternetTmpFiles  
}
Function DeleteTemp($Files)
{
    #This function is to delete the file in an array
    Foreach ($File in $Files)
    {
        $path = $File.FullName
        If($path -ne $null)
        {
            Try
            {
                #Delete the item 
                Remove-Item -Path $path -Force -Recurse -ErrorAction Ignore
                Write-Host "Delete ""$path"" successfully."
            }
            Catch
            {
                Write-Warning """$path"":Access is denied. Please close the IE browser or related programs"
            }
        }
    }
}
Clear-OSCTempFile
