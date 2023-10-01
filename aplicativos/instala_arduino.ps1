choco uninstall arduino -n

Get-NetFirewallRule -DisplayName "Arduino IDE*"|Remove-NetFirewallRule
Get-NetFirewallRule -DisplayName "Mdns-discovey*"|Remove-NetFirewallRule

New-NetFirewallRule -DisplayName "Mdns-discovey_in" -Direction Inbound -Action Allow -Program "$env:LOCALAPPDATA\arduino15\packages\builtin\tools\mdns-discovery\1.0.9\mdns-discovery.exe" -Enabled True
New-NetFirewallRule -DisplayName "Mdns-discovey_out" -Direction Outbound -Action Allow -Program "$env:LOCALAPPDATA\arduino15\packages\builtin\tools\mdns-discovery\1.0.9\mdns-discovery.exe" -Enabled True
New-NetFirewallRule -DisplayName "Arduino IDE_in" -Direction Inbound -Action Allow -Program "$env:LOCALAPPDATA\programs\arduino ide\arduino ide.exe" -Enabled True
New-NetFirewallRule -DisplayName "Arduino IDE_out" -Direction Outbound -Action Allow -Program "$env:LOCALAPPDATA\programs\arduino ide\arduino ide.exe" -Enabled True

choco install arduino --force --silent --y

start "$env:localappdata\Programs\Arduino IDE\Arduino IDE.exe " -RedirectStandardOutput "NUL"
