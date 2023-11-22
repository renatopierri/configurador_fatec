
choco uninstall xampp-80 --force  --silent --y


Write-Host "Ajustando o Firewall."
Get-NetFirewallRule -DisplayName "Apache*"|Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "mysqld*"|Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "FileZilla*"|Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Mercury*"|Remove-NetFirewallRule

New-NetFirewallRule -DisplayName "Apache HTTP Server" -Direction Inbound -Protocol TCP -Action Allow -Program "C:\xampp\apache\bin\httpd.exe" -Enabled True
New-NetFirewallRule -DisplayName "Apache HTTP Server" -Direction Inbound -Protocol UDP -Action Allow -Program "C:\xampp\apache\bin\httpd.exe" -Enabled True

New-NetFirewallRule -DisplayName "mysqld" -Direction Inbound -Protocol TCP -Action Allow -Program "C:\xampp\mysql\bin\mysqld.exe" -Enabled True
New-NetFirewallRule -DisplayName "mysqld" -Direction Inbound -Protocol UDP -Action Allow -Program "C:\xampp\mysql\bin\mysqld.exe" -Enabled True

New-NetFirewallRule -DisplayName "FileZilla Server" -Direction Inbound -Protocol TCP -Action Allow -Program "C:\xampp\filezillaftp\filezillaserver.exe" -Enabled True
New-NetFirewallRule -DisplayName "FileZilla Server" -Direction Inbound -Protocol UDP -Action Allow -Program "C:\xampp\filezillaftp\filezillaserver.exe" -Enabled True

New-NetFirewallRule -DisplayName "Mercury/32 Core Processing Module v4.62" -Direction Inbound -Protocol TCP -Action Allow -Program "C:\xampp\mercurymail\mercury.exe" -Enabled True
New-NetFirewallRule -DisplayName "Mercury/32 Core Processing Module v4.62" -Direction Inbound -Protocol UDP -Action Allow -Program "C:\xampp\mercurymail\mercury.exe" -Enabled True
Write-Host "Firewall Ajustado."

choco install xampp-80 --force --silent --y
