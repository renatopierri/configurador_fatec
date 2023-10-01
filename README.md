# Configurador Fatec
Este script Powershell é para ajudar na instalação das aplicações utilizadas nos computadores da Fatec Barueri.

**Descrição dos arquivos:**<br>
- **instala_fatec.ps1:** Instalador dos aplicativos. Ele le a configuração do arquivo configura_instalador.ini e faz a chamada dos instaladores de aplicativo. 
- **configura_instalador.ini:**  Esse arquivo tem os parâmetros de instalacao dos aplicativos, no seguinte formato: \<diretorio\>\;<executavel\>;\<parametro\>;\<descricao\>.
Caso queira escolher quais programas deseja instalar, basta comentar a linha com o parametro de instalacao do aplicativo.
- **pasta office:** Contem os arquivos de instalacao do pacote office e o script "office.ps1" de personalização do office.
- **pasta aplicativos:** Contem os instaladores dos demais aplicativos e o script "apteste.ps1" de instalacao dos mesmos.<br>

**Para rodar o script**<br>
Abrir o prompt do Powershell como administrador.
Navegar até a pasta raiz do Configurador.
Executar o comando .\instala_fatec.ps1
Caso necessario, rodar o comando Set-ExecutionPolicy Unrestricted.
Os arquivos de instalacao do office deve ficar na pasta office.
Os arquivos de instalacao dos demais programas devem ficar na pasta aplicativos.

**Em construcao**
Este instalador esta em construcao e novos scripts de instalacao de aplicativos serao adicionados conforme necessario.
Caso queira sugerir melhorias, entre em contato comigo.

**Realizado por Renato de Pierri / nets-nuts.com.br**
