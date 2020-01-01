# Usage: (New-Object Net.WebClient).Proxy.Credentials=[Net.CredentialCache]::DefaultNetworkCredentials;iwr('https://raw.githubusercontent.com/usagi/vcpkg_chii/master/bootstrap.ps1')|iex

$BASE = 'https://raw.githubusercontent.com/usagi/vcpkg_chii/master/cmake/'
$FILES = @(
  'vcpkg_chii.cmake',
  'vcpkg_chii_enable.cmake',
  'vcpkg_chii_auto_triplet.cmake',
  'vcpkg_chii_auto_toolchain_file.cmake', 
  'vcpkg_chii_find_package.cmake'
)

Write-Output 'vcpkg_chii/bootstrap.sh: [ LOG ] Congraturations, the bootstrap of vcpkg_chii be started.'

if (!( Test-Path cmake) ) {
  New-Item cmake -ItemType Directory
  if ( !$? -or !( Test-Path cmake) ) {
    Write-Output 'vcpkg_chii/bootstrap.sh: [ FATAL ] Could not create the cmake directory.'
    exit 2
  }
  Write-Output 'vcpkg_chii/bootstrap.sh: [ LOG ] `New-Item cmake -ItemType Directory` was succeeded.'
}

Set-Location cmake
if ( ! $? ) {
  Write-Output 'vcpkg_chii/bootstrap.sh: [ FATAL ] `Set-Location cmake` was failed.'
  exit 3
}
Write-Output 'vcpkg_chii/bootstrap.sh: [ LOG ] `Set-Location cmake` was succeeded.'

$COUNT_OF_FILES = $FILES.Length

Write-Output "vcpkg_chii/bootstrap.sh: [ LOG ] Begin download the ${COUNT_OF_FILES} .cmake files..."

foreach ( $FILE in $FILES ) {
  $URI = $BASE + $FILE
  Write-Output "vcpkg_chii/bootstrap.sh: [ LOG ] Downloading... $URI"
  Invoke-WebRequest -Uri $URI -OutFile $FILE
  if ( ! $? ) {
    Write-Output 'vcpkg_chii/bootstrap.sh: [ FATAL ] `Invoke-WebRequest` was failed.'
    exit 3
  }
}

Write-Output 'vcpkg_chii/bootstrap.sh: [ LOG ] Completed, you can use `include(cmake/vcpkg_chii.cmake)` in your CMakeLists.txt and use vcpkg_chii features!'
Write-Output 'vcpkg_chii/bootstrap.sh: [ LOG ] ( See also the example <https://github.com/usagi/vcpkg_chii/blob/master/example/CMakeLists.txt#L1>. )'
