function Get-PP_ProfileName {
  param (
    [OutputType([String])]
    [Parameter(Mandatory)]   
    [String] $Path
  )

  switch ($Path) {
    $PROFILE.CurrentUserCurrentHost {
      return 'Current User, Current Host'
    }
    $PROFILE.CurrentUserAllHosts {
      return 'Current User, All Hosts'
    }
    $PROFILE.AllUsersCurrentHost {
      return 'All Users, Current Host'
    }
    $PROFILE.AllUsersAllHosts {
      return 'All Users, All Hosts'
    }
    default {
      return 'Unknown'
    }
  }
}