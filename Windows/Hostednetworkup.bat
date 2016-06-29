REM Hostednetwork up for windows, By Overlord
REM First, turn off the output
@echo off
REM Set the properties of the network
REM SSID: replace for the name of your network
REM key: replace for something you remember, must use at least 8 characters. Aa8/
REM keyusage: this set the key for later use
netsh wlan set hostednetwork mode=allow ssid=Example key=01234567 keyUsage=persistent
REM after adjust the hostednetwork, the following start the same
netsh wlan start hostednetwork
REM Show a message to the user, about the network is up
msg %username% Hosted Network ready
REM EOF
exit
