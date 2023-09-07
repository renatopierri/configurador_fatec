$diretorioCorrente = Get-Location
$configura_instalador = Get-Content "$diretorioCorrente\configura_instalador.ini"

foreach ($item in $configura_instalador){
    if ($($item.Equals("[Aplicativo]"))){
        # Write-Host ("Aqui tem um rotulo $item")
        Continue
    }
    try{
        $comentario = $item.Substring(0,1)
    }
    catch{
        $comentario = ""
    }
    if($($comentario.Equals("#")) -or $($comentario.Equals(" ")) -or $($comentario.Equals(""))){
        # Write-Host ("Aqui tem um Comentario ou espaco $item")
        Continue
    }

    $programa_dir, $programa_executavel, $programa_parametro, $programa_nome = $item.Split(";")
   
    $cmd = "$diretorioCorrente\$programa_dir\$programa_executavel"
    #write-host ("Proximo comando: $cmd $programa_parametro")

    Invoke-Expression "$cmd $programa_parametro"

}


