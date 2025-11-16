<#
.SYNOPSIS
Gets the menu for all the cafeterias nearby.

.DESCRIPTION
Gets the menu for all the cafeterias nearby.
#>
function Get-MensaMenu {
  Add-Type -AssemblyName System.Device
  $GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher
  $GeoWatcher.Start()

  while (($GeoWatcher.Status -ne 'Ready') -and ($GeoWatcher.Permission -ne 'Denied')) {
    Start-Sleep -Milliseconds 100
  }

  if ($GeoWatcher.Permission -eq 'Denied'){
    Write-Warning 'No access to current location.'
    return
  } else {
    $location = $GeoWatcher.Position.Location
  }

  $lat = $location.Latitude -Replace ',','.'
  $long = $location.Longitude -Replace ',','.'
  $currentDateTime = (Get-Date -Format 'yyyy-MM-dd')

  $jsonCampi = (Invoke-WebRequest "https://openmensa.org/api/v2/canteens?near[lat]=$lat&near[lng]=$long&near[dist]=5" -SkipHttpErrorCheck).Content | ConvertFrom-Json

  Clear-Host

  foreach ($campus in $jsonCampi) {
    $jsonMeals = (Invoke-WebRequest "https://openmensa.org/api/v2/canteens/$($campus.id)/days/$($currentDateTime)/meals" -SkipHttpErrorCheck).Content | ConvertFrom-Json

    $meals = @()
    $number = 0;

    foreach ($meal in $jsonMeals) {
      $meals += [PSCustomObject]@{Number=$number;Meal=$meal.name;Category=$meal.category;Price=$meal.prices.students}
      $number = $number + 1
    }

    if ($meals.count -gt 0) {
      Write-Host "Cafeteria: $($campus.name) - $($currentDateTime)"
      $meals | Format-Table
    }
  }
}
