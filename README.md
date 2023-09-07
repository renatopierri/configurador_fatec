# Configurador Fatec
Este script Powershell é para ajudar na instalação das aplicações utilizadas nos computadores da Fatec Barueri.

**Descrição dos arquivos:**<br>
- **instala_fatec.ps1:** Instalador dos aplicativos. Ele lê a configuração do arquivo configura_instalador.ini e faz a chamada dos instaladores de aplicativo. 
- **configura_instalador.ini:**  Esse arquivo tem os parâmetros de instalação dos aplicativos, no seguinte formato: \<diretorio\>\;<executavel\>;\<parametro\>;\<descricao\>.
- **pasta office:** Contém os arquivos de instalação do pacote office e o script "office.ps1" de personalização do office.
- **pasta aplicativos:** Contém os instaladores dos demais aplicativos e o script "apteste.ps1" de instalação dos mesmos.

