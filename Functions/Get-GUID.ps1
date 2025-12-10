<#
.SYNOPSIS
Gets a random Globally Unique Identifier (GUID).

.DESCRIPTION
Gets a random Globally Unique Identifier (GUID).
The GUID is using uppercase characters and curly brackets.

.INPUTS
None.

.OUTPUTS
System.String. Sends a Globally Unique Identifier out the pipeline.
#>
function Get-GUID {
  (New-Guid).ToString('B').ToUpper()
}

Set-Alias -Name Get-UUID -Value Get-GUID
