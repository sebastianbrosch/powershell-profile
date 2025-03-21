<#
.SYNOPSIS
  Gets a random Globally Unique Identifier (GUID).

.DESCRIPTION
  Gets a random Globally Unique Identifier (GUID).
  The GUID is using uppercase characters and curly brackets.

.INPUTS
  None.

.OUTPUTS
  System.String. A Globally Unique Identifier (GUID).

.EXAMPLE
  PS> Get-GUID
  Get a Globally Unique Identifier (GUID).
#>
function Get-PP_GUID {
  (New-Guid).ToString('B').ToUpper()
}