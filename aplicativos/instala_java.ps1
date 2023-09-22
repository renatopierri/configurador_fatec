$programa_parametro=$args[0]
$diretorioCorrente = Get-Location

"Instalando o Java $programa_parametro"

$PastaOracle = "C:\Program Files\Oracle"
$PastaJava = "C:\Program Files\Oracle\$programa_parametro"

"Verificando se existe a pasta [$PastaOracle]."
if (Test-Path -Path $PastaOracle) {
    "Pasta [$PastaOracle] existe!"
        "Verificando se existe a pasta [$PastaJava]."
    if (Test-Path -Path $PastaJava) {
        "Pasta [$PastaJava] existe! ... removendo agora."
        Remove-Item -Recurse -Force $PastaJava
        "Pasta [$PastaJava] foi removida.`n"
    } 
   
} else {
    "Pasta [$PastaOracle] não existe ... criando agora."
    mkdir "C:\Program Files\Oracle"
    "Pasta [$PastaOracle] criada."
}

"Copiando os arquivos Java para $PastaJava"
Copy-Item -Path "$diretorioCorrente\aplicativos\$programa_parametro" -Destination "C:\Program Files\Oracle\" -Recurse
"Copiado.`n"



"Configurando a variavel JAVA_HOME para $PastaJava"
[Environment]::SetEnvironmentVariable("JAVA_HOME", "$PastaJava", "Machine")
"Variavel JAVA_HOME criada.`n"


"Path atual"
write-host "$env:Path"

"`nAdicionando o caminho do Java no Path."
$novoPath = "$PastaJava\bin;" + $env:Path
[Environment]::SetEnvironmentVariable("Path", "$novoPath", "Machine")

#Atualizando a variavel de ambiente da sessao do Powershell
$Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")  

write-host "$env:Path`n"
"Java Instalado"



