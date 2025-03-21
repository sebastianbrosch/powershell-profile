<#
.SYNOPSIS
  Gets a random Globally Unique Identifier (GUID).

.DESCRIPTION
  Gets a random Globally Unique Identifier (GUID).
  The GUID is using uppercase characters and curly brackets.

.PARAMETER Clipboard
  Specifies whether the GUID should be set to the clipboard.

.INPUTS
  None.

.OUTPUTS
  System.String. Sends a Globally Unique Identifier out the pipeline.

.EXAMPLE
  PS> .\Get-GUID
  Send a Globally Unique Identifier out the pipeline.

.EXAMPLE
  PS> .\Get-GUID -Clipboard
  Set a Globally Unique Identifier to the clipboard.
#>


param (
  [switch] $Clipboard
)

$GUID = (New-Guid).ToString('B').ToUpper()

if ($Clipboard) {
  Set-Clipboard -Value $GUID
} else {
  return $GUID
}