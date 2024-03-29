$pkg_name = "powershell"
$pkg_origin = "dem"
$pkg_version = "6.2.1"
$pkg_license = @("MIT")
$pkg_upstream_url = "https://msdn.microsoft.com/powershell"
$pkg_description = "PowerShell is a cross-platform (Windows, Linux, and macOS) automation and configuration tool/framework that works well with your existing tools and is optimized for dealing with structured data (e.g. JSON, CSV, XML, etc.), REST APIs, and object models. It includes a command-line shell, an associated scripting language and a framework for processing cmdlets."
$pkg_maintainer = "The Habitat Maintainers <humans@habitat.sh>"
$pkg_source = "https://github.com/PowerShell/PowerShell/releases/download/v$pkg_version/PowerShell-$pkg_version-win-x64.zip"
$pkg_shasum = "6bcc0f80ca549a8adb317b2ec1294f103c4bf75cc29efa8ac03a27f9a860b1f4"
$pkg_filename = "powershell-$pkg_version-win-x64.zip"
$pkg_bin_dirs = @("bin")

function Invoke-Unpack {
  Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_filename" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}

function Invoke-Check() {
  $versionTable = ./powershell.exe -command '$PSVersionTable'
  $passed = $false

  $versionTable | % {
    if ($_.Trim().StartsWith('GitCommitId')) {
      $passed = $_.Trim().EndsWith($pkg_version)
    }
  }

  if (!$passed) {
    Write-Error "Check failed to confirm powershell version as $pkg_version"
  }
}
