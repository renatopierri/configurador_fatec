$Env:ChocolateyLastPathUpdate = ""
$Env:ChocolateyInstall = ""
$chocoHome=""
$Env:ChocolateyLastPathUpdate = [System.Environment]::GetEnvironmentVariable("ChocolateyLastPathUpdate","User")
$Env:ChocolateyInstall = [System.Environment]::GetEnvironmentVariable("ChocolateyInstall","Machine") 

Try{
    $chocoHome = $env:ChocolateyInstall.ToString()
    Write-Host "Chocolatey instalado em $chocoHome ... removendo."
    Remove-item -Recurse -Force "$chocoHome"
    $Env:ChocolateyLastPathUpdate = [Environment]::SetEnvironmentVariable("ChocolateyLastPathUpdate", $null ,"User") 
    $Env:ChocolateyInstall = [Environment]::SetEnvironmentVariable("ChocolateyInstall", $null ,"Machine")
    Write-Host "Removido.`n"
}catch{
    Write-Host "Chocolatey nao encontrado ... instalando.`n"
}finally{
    Write-Host "Instalando Chocolatey.`n"
    Set-ExecutionPolicy Bypass -Scope Process -Force; 
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    $chocoHome = $env:ChocolateyInstall.ToString()
    Write-Host "`nChocolatey instalado em $chocoHome.`n"
}
