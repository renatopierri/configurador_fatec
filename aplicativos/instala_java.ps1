$programa_parametro=$args[0]
$diretorioCorrente = Get-Location

"Instalando o Java $programa_parametro"

$PastaJavaRaiz = "C:\Program Files\Java"
$PastaJavaVersao = "C:\Program Files\Java\$programa_parametro"

"Verificando se existe a pasta [$PastaJavaRaiz]."
if (Test-Path -Path $PastaJavaRaiz) {
    "Pasta [$PastaJavaRaiz] existe!"
        "Verificando se existe a pasta [$PastaJavaVersao]."
    if (Test-Path -Path $PastaJavaVersao) {
        "Pasta [$PastaJavaVersao] existe! ... removendo agora."
        Remove-Item -Recurse -Force $PastaJavaVersao
        "Pasta [$PastaJavaVersao] foi removida."
    }else{
        "Pasta [$PastaJavaVersao] nao existe!"
    } 
   
} else {
    "Pasta [$PastaJavaRaiz] não existe ... criando agora."
    mkdir "$PastaJavaRaiz"
    "Pasta [$PastaJavaRaiz] criada."
}

"Copiando os arquivos Java para $PastaJavaVersao"
Copy-Item -Path "$diretorioCorrente\aplicativos\$programa_parametro" -Destination "$PastaJavaRaiz" -Recurse
"Copiado.`n"
#======================


if (!($programa_parametro -like "*_Java32*")){
    Write-Host "Configurando Java 64bits."
    
    "Configurando a variavel JAVA_HOME para $PastaJavaVersao"
    [Environment]::SetEnvironmentVariable("JAVA_HOME", "$PastaJavaVersao", "Machine")
    "Variavel JAVA_HOME criada.`n"

    write-host "Verificando se precisa atualizar a variavel %PATH%`n$env:Path`n"

    if(!$env:Path.Contains("$PastaJavaVersao\bin")){
        $novoPath = "$PastaJavaVersao\bin;" + $env:Path
        [Environment]::SetEnvironmentVariable("Path", "$novoPath", "Machine")

        #Atualizando a variável de ambiente da sessão do Powershell
        $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") # + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")  
        write-host "Variavel %PATH% atualizada para:`n$env:Path`n"
        
    }else{
        write-host "Variavel %PATH% ja esta atualizada`n"
    }
    write-host "Java 64bits instalado em C:\Program Files\Java\$programa_parametro`n"

}else{
    Write-Host "Java 32bits instalado em C:\Program Files\Java\$programa_parametro"
    
}




