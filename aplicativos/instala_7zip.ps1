$instalador=$args[0]
$diretorioCorrente = Get-Location

Write-Host "Instalando 7zip."
Invoke-Expression "$diretorioCorrente\aplicativos\$instalador"

Write-host "Verificando se precisa adicionar 7zip na variavel %PATH%."
if(!$env:Path.Contains("7-Zip")){
    $novoPath = "$env:ProgramFiles\7-Zip;" + $env:Path
    [Environment]::SetEnvironmentVariable("Path", "$novoPath", "Machine")
    #Atualizando a variável de ambiente da sessão do Powershell
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") # + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")  
    write-host "`nVariavel %PATH% atualizada para:`n$env:Path`n"        
}else{
    write-host "Variavel %PATH% ja esta atualizada"
}

Write-Host "Instalado.`n"