$diretorioCorrente = Get-Location
$diretorioDestino = $env:ProgramFiles
$ArquivoBonita=$args[0]
$PastaBonita = $ArquivoBonita -replace ".{4}$"
$PastaBonitaRaiz = "$diretorioDestino\$PastaBonita"

Write-Host "Instalando o Bonita Studio`n"

Write-Host "Verificando se existe a pasta [$PastaBonitaRaiz]."
if (Test-Path -Path $PastaBonitaRaiz) {
    Write-Host "Pasta encontrada ... Removendo pasta [$PastaBonitaRaiz] e seu conteudo."
    Remove-Item -Recurse -Force $PastaBonitaRaiz
    Write-Host "Pasta removida.`n"
}else{
    Write-Host "Pasta [$PastaBonitaRaiz] não existe ... criando agora."
    mkdir "$PastaBonitaRaiz"
    Write-Host "Pasta [$PastaBonitaRaiz] criada.`n"
} 

write-host "Descompactando os arquivos Bonita para $PastaBonitaRaiz com 7zip."    
$cmd = "7z"
$programa_parametro =  "x  $diretorioCorrente\aplicativos\$ArquivoBonita -o"""+$env:ProgramFiles+""" -y"
Invoke-Expression "$cmd $programa_parametro"
write-host "Descompactado.`n"

write-host "Copiando o arquivo BonitaStudioCommunity.ini para $PastaBonitaRaiz." 
Copy-Item  -Path $diretorioCorrente\aplicativos\BonitaStudioCommunity.ini -Destination $PastaBonitaRaiz -force -ErrorAction SilentlyContinue
write-host "Copia finalizada.`n"

write-host "Acertando a permissão dos arquivos de instalacao do Bonita."
$todaACL = Get-Acl -path $PastaBonitaRaiz
$usuario = "BUILTIN\Usuários"
$permissao = New-Object System.Security.AccessControl.FileSystemAccessRule($usuario, "Modify", "ContainerInherit,ObjectInherit", "None", "Allow")
$todaACL.SetAccessRule($permissao)
$todaACL | Set-Acl "$PastaBonitaRaiz"
write-host "Permissoes ajustadas.`n"

Write-Host "Verificando se o atalho Bonita existe"
$ShortcutPath = "$env:PUBLIC\Desktop\Bonita.lnk"
$ShortcutCheck = Test-Path -Path $ShortcutPath
if($ShortcutCheck -eq 'True'){
    Write-Host "Atalho encontrado ... removendo"
    Remove-Item $ShortcutPath -Force
    Write-Host "Atalho removido"
}else{
    Write-Host "Atalho não encontrado."
}

Write-Host "Criando atalho do Bonita."
$TargetPath = "$PastaBonitaRaiz\BonitaStudioCommunity.exe" 
$WshShell = New-Object -ComObject WScript.Shell 
$Shortcut = $WshShell.CreateShortcut($ShortcutPath) 
$Shortcut.TargetPath = $TargetPath 
$Shortcut.IconLocation = $TargetPath
$Shortcut.Save()
Write-Host "Atalho criado.`n"
Write-Host "Ajustando o Firewall"
Get-NetFirewallRule -DisplayName "OpenJDK Platform binary_bonita*"|Remove-NetFirewallRule
New-NetFirewallRule -DisplayName "OpenJDK Platform binary_bonita_in_javaw" -Direction Inbound -Protocol TCP -Action Allow -Program "$env:ProgramFiles\java\jdk-11.0.20.1+1\bin\javaw.exe" -Enabled True
New-NetFirewallRule -DisplayName "OpenJDK Platform binary_bonita_in_javaw" -Direction Inbound -Protocol UDP -Action Allow -Program "$env:ProgramFiles\java\jdk-11.0.20.1+1\bin\javaw.exe" -Enabled True
New-NetFirewallRule -DisplayName "OpenJDK Platform binary_bonita_in_java" -Direction Inbound -Protocol TCP -Action Allow -Program "$env:ProgramFiles\java\jdk-11.0.20.1+1\bin\java.exe" -Enabled True
New-NetFirewallRule -DisplayName "OpenJDK Platform binary_bonita_in_java" -Direction Inbound -Protocol UDP -Action Allow -Program "$env:ProgramFiles\java\jdk-11.0.20.1+1\bin\java.exe" -Enabled True
Write-Host "Firewall Ajustado."

write-host "Bonita Studio instalado em $PastaBonitaRaiz`n"