@echo off
netsh wlan stop hostednetwork
netsh wlan show hostednetwork
msg %username% Hosted Network Down
exit
