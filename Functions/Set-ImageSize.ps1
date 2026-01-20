<#
.SYNOPSIS
Resize one or more images to a specified dimension using ImageMagick.

.DESCRIPTION
Resize one or more images to a specified width and height using ImageMagick.
The function processes either a single image file or all JPG/PNG images in a directory.
Images are cropped to center and filled to exact dimensions while maintaining quality.
Resized images are saved to the specified output directory or will be overwritten.

.PARAMETER Path
The path to a directory containing images or a single image file.

.PARAMETER Height
The target height in pixels for the resized images.

.PARAMETER Width
The target width in pixels for the resized images.

.PARAMETER Output
The output directory name. If relative, it's created relative to the input path.
If not specified, defaults to the input directory.

.EXAMPLE
Set-ImageSize -Path "C:\Images" -Width 800 -Height 600 -Output "Resized"

.EXAMPLE
Set-ImageSize -Path "C:\Images\photo.jpg" -Width 1920 -Height 1080 -Output "Output"

.NOTES
Requires ImageMagick to be installed and available in the system PATH.
Download from: https://imagemagick.org/script/download.php
#>
function Set-ImageSize {
  [CmdletBinding()]

  param (
    [Parameter(Mandatory=$true)]
    [string] $Path,

    [Parameter(Mandatory=$true)]
    [int] $Height,

    [Parameter(Mandatory=$true)]
    [int] $Width,

    [Parameter(Mandatory=$false)]
    [string] $Output
  )

  process {
    if (-not (Get-Command magick -ErrorAction SilentlyContinue)) {
      Write-Error "ImageMagick is not available. Please make sure ImageMagick is installed."
      Write-Error "You can download ImageMagick here: https://imagemagick.org/script/download.php"
      return
    }

    if (-not (Test-Path -Path $Path)) {
      Write-Warning "The input directory or file does not exist."
      return
    }

    if (Test-Path -Path $Path -PathType Container) {
      $images = @(Get-ChildItem -Path (Join-Path -Path $Path -ChildPath "*") -Include "*.jpg", "*.png" -File)

      if ($images.Count -eq 0) {
        Write-Warning "No JPG or PNG images found in input directory."
        return
      }

      $inputPath = Join-Path -Path $Path -ChildPath "*.{jpg,png}"

      if ($Output) {
        $outputPath = Join-Path -Path $Path -ChildPath $Output
      } else {
        $outputPath = $Path
      }
    } else {
      $inputPath = $Path

      if ($Output) {
        $outputPath = Join-Path -Path (Split-Path -Path $Path -Parent) -ChildPath $Output
      } else {
        $outputPath = Split-Path -Path $Path -Parent
      }
    }

    New-Item -ItemType Directory -Force -Path $outputPath | Out-Null;
    $size = "${Width}x${Height}"
    Write-Verbose "Resizing images to: $size"

    magick mogrify `
      -resize "${size}^" `
      -gravity center `
      -extent $size `
      -quality 100 `
      -path $outputPath `
      $inputPath

    Write-Verbose "Image resizing completed."
  }
}
