$programa_parametro=$args[0]
$diretorioCorrente = Get-Location
$diretorioDestino = "C:\Program Files"
$PastaNetbeansRaiz = "$diretorioDestino\netbeans"
$PastaNetbeansBin = "$PastaNetbeansRaiz\bin"

Write-Host "Instalando o Netbeans"

"Verificando se existe a pasta [$PastaNetbeansRaiz]."
if (Test-Path -Path $PastaNetbeansRaiz) {
    "Removendo pasta [$PastaNetbeansRaiz] e seu conteudo."
    Remove-Item -Recurse -Force $PastaNetbeansRaiz
    "Pasta removida."
}else{
    "Pasta [$PastaNetbeansRaiz] não existe ... criando agora."
    mkdir "$PastaNetbeansRaiz"
    "Pasta [$PastaNetbeansRaiz] criada.`n"
} 

write-host "Copiando os arquivos Netbeans para $PastaNetbeansRaiz"    
Expand-Archive -Path $diretorioCorrente\aplicativos\netbeans.zip -DestinationPath $diretorioDestino -Force
write-host "Copiado.`n"

Write-Host "Verificando se o atalho Netbeans existe"
$ShortcutPath = "$env:PUBLIC\Desktop\Netbeans.lnk"
$ShortcutCheck = Test-Path -Path $ShortcutPath
if($ShortcutCheck -eq 'True'){
    Write-Host "Atalho encontrado ... removendo"
    Remove-Item $ShortcutPath -Force
    Write-Host "Atalho removido"
}else{
    Write-Host "Atalho não encontrado..."
}

Write-Host "Criando atalho do Netbeans.`n"
$TargetPath = "$PastaNetbeansBin\netbeans64.exe" 
$WshShell = New-Object -ComObject WScript.Shell 
$Shortcut = $WshShell.CreateShortcut($ShortcutPath) 
$Shortcut.TargetPath = $TargetPath 
$Shortcut.IconLocation = "$PastaNetbeansBin\netbeans64.exe"
$Shortcut.Arguments = $programa_parametro
$Shortcut.Save()

Write-host "Verificando se precisa atualizar a variavel %PATH%`n$env:Path`n"
if(!$env:Path.Contains("$PastaNetbeansBin")){
    $novoPath = "$PastaNetbeansBin;" + $env:Path
    [Environment]::SetEnvironmentVariable("Path", "$novoPath", "Machine")

    #Atualizando a variável de ambiente da sessão do Powershell
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") # + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")  
    write-host "Variavel %PATH% atualizada para:`n$env:Path`n"
}else{
    write-host "Variavel %PATH% ja esta atualizada`n"
}

write-host "Netbeans 64bits instalado em $PastaNetbeansRaiz`n"






