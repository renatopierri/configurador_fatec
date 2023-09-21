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
        "Pasta [$PastaJava] foi removida."
    } 
   
} else {
    "Pasta [$PastaOracle] não existe ... criando agora."
    mkdir "C:\Program Files\Oracle"
    "Pasta [$PastaOracle] criada."
}

"Copiando o Java para a pasta [$programa_parametro]"
Copy-Item -Path ".\aplicativos\$programa_parametro" -Destination "C:\Program Files\Oracle\" -Recurse
"Copiado."

"Criando a variavel JAVA_HOME."
[Environment]::SetEnvironmentVariable("JAVA_HOME", "$PastaJava\bin", "Machine")
"Variavel JAVA_HOME criada."

"Adicionando o caminho do Java no Path."
$novoPath = "$PastaJava\bin;" + $env:Path
[Environment]::SetEnvironmentVariable("Path", "$novoPath", "Machine")
"Pronto."
"Java Instalado"


