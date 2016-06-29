REM Release, flush and renew usin ipconfig, this is only for Windows
REM First thing, just to launch and avoid botter the user with tech details
@echo off
REM The option release the actual connection
ipconfig /release
REM Then flush the dns cache
ipconfig /flushdns
REM To finish, renew the connection for the network
ipconfig /renew
REM Display a message to the user, pointing that the maintenance was successfully modified
msg %username% The network maintenance was done
exit
