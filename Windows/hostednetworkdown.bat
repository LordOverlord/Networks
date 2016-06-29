REM Hostednetwork down for windows, By Overlord
@echo off
REM Just for stop the hostednetwork
netsh wlan stop hostednetwork
REM Display a message to the user
msg %username% Hosted Network Down
REM EOF
exit
