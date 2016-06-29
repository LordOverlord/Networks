@echo off
netsh wlan set hostednetwork mode=allow ssid=Overlord key=12345678 keyUsage=persistent
netsh wlan start hostednetwork
netsh wlan show hostednetwork
msg %username% Hosted Network ready
exit
