$token = "8268716558:AAH_sjcx5wfc_Y33KeSGfHv7zek1wsDZ5Z0"
$meuID = "5974171362"
$url = "https://api.telegram.org/bot$token/getUpdates"

Write-Host "Bot aguardando ordens..."

while($true) {
    try {
        # Consulta as últimas mensagens no bot
        $response = Invoke-RestMethod -Uri $url -UseBasicParsing
        $ultimaMsg = $response.result[-1].message.text
        $quemMandou = $response.result[-1].message.from.id

        # Verifica se a mensagem foi enviada por VOCÊ
        if ($quemMandou -eq $meuID) {
            
            if ($ultimaMsg -eq "/video") {
                # Aumenta o volume e abre o vídeo
                $obj = New-Object -ComObject WScript.Shell
                for($i=0; $i -le 50; $i++) { $obj.SendKeys([char]175) }
                start "https://www.youtube.com/watch?v=qHoAEWK59nE&list=RDqHoAEWK59nE&start_radio=1"
                Start-Sleep -Seconds 5
                $obj.SendKeys('f') # Tela cheia
                
                # Opcional: Avisar no seu celular que deu certo
                Invoke-RestMethod -Uri "https://api.telegram.org/bot$token/sendMessage?chat_id=$meuID&text=Vídeo executado!"
            }
        }
    } catch { }
    
    Start-Sleep -Seconds 5 # Espera 5 segundos para não sobrecarregar
}