# PowerShell Profile

## Installation

``` shell
iwr -useb https://raw.githubusercontent.com/sebastianbrosch/powershell-profile/main/Setup.ps1 | iex
```

## Configurations

### Git
It is possible to store multiple Git configurations as JSON. The Git configuration is stored in `Configuration/Git-Profiles.json` within the profile.

``` json
[{
    "name": "John Doe",
    "email": "john.doe@example.org",
    "signingkey": "1A2B3C4D5E6F7G8H",
    "sshfile": "ssh-john-doe-example-org"
},
{
    "name": "Jane Doe",
    "email": "jane.doe@example.org",
    "signingkey": "1A2B3C4D5E6F7G8H",
    "sshfile": "ssh-jane-doe-example-org"
}]
```

Initialization can be performed using the following command.

``` powershell
Initialize-GitConfig -Email john.doe@example.org
```