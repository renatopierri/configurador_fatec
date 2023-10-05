$caminhho = "$env:ProgramFiles\Mozilla Firefox\uninstall"
if (Test-Path $caminhho){
    $desinstalador = "$caminhho\helper.exe"
    &$desinstalador /S
}
choco install firefox --force --silent --y

choco uninstall googlechrome -n
choco install googlechrome --force --silent --y