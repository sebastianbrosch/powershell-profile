$ProfileFolder = Split-Path $PROFILE
Import-Module $(Join-Path -Path $ProfileFolder -ChildPath "Modules\PowerShell")
Import-Module $(Join-Path -Path $ProfileFolder -ChildPath "Modules\Utils")

Write-Host -ForegroundColor Green "You are using the PowerShell profile $(Get-PP_ProfileName $PROFILE)."
Write-Host -ForegroundColor Green "Your profile is located at: $ProfileFolder"