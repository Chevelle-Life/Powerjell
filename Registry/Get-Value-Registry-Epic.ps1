#Search Reg and display Epic Games Key Value

$Epic = "{BBEF894A-4F0D-C109-97D7-F9A34620D73E}"
$pattern = '*Program Files/Epic Games/5.1/*'
Get-Item -LiteralPath HKCU:"\SOFTWARE\Epic Games\Unreal Engine\Builds\" -PipelineVariable key |
		ForEach-Object Property | 
			Where-Object { 
			  $valueName = ($_, '')[$_ -eq '(default)']
			  $valueName -like $pattern -or $key.GetValue($valueName) -like $pattern 
			}			
			
