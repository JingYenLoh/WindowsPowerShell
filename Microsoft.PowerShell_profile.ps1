# Imports
Import-Module posh-git
Import-Module z

# Settings
Set-PSReadlineOption -EditMode Emacs
Set-Theme Sorin

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# I need help a lot
Set-Alias -Name gh -Value Get-Help
Set-Alias -Name l -Value Get-ChildItem

# Emacs power
Set-Alias -Name e -Value runemacs.exe

# Make directory and cd into it
Function mkcd {
  Param
  (
    # Parameter help description
    [Parameter(Mandatory = $true)]
    [string]
    $FolderName
  )
  New-Item -ItemType "directory" -Path $FolderName;
  Set-Location $FolderName;
}

# Lazy way of starting Android Emulator
# function Start-ReactNativeEmulator {
#   C:\Android\sdk\tools\emulator.exe -avd Nexus_5X_API_23
# }

# Set-Alias -Name rnemu -Value Start-ReactNativeEmulator

Function doom {
  & "$env:USERPROFILE\.emacs.d\bin\doom.cmd" $args
}

Function .. {
  Set-Location ..
}

Function rmrf {
  Param
  (
    # Parameter help description
    [Parameter(Mandatory = $true)]
    [string]
    $Target
  )
  Remove-Item -Recurse -Force $Target
}

Function ghci {
  stack ghci
}

Function ~ {
  Set-Location ~
}

Function Get-Password {
  [CmdletBinding()]
  Param(
    [ArgumentCompleter({
      $passArg = $args[2];
      gopass list --flat | Select-String ".*$passArg.*" | Sort-Object
    })]
    [String]
    $Password
  )

  process {
    gopass -c $Password
  }

}

Set-Alias -Name pass -Value Get-Password
Set-Alias -Name unzip -Value Expand-Archive
