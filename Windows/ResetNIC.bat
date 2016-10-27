REM Reset NIC 
@echo off 
REM get the time and date and set for change format
FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
REM set the format of date and time for timestamp
SET mydate=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%_%DTS:~8,2%-%DTS:~10,2%-%DTS:~12,2%
REM Set the name of the logfile
set logfile=log_%mydate%_%username%.log
REM Disable the ethernet interface, replace "ethernet" with the name of the adapter
netsh interface set interface name="ethernet" admin=disabled > %logfile%
REM Delay time, replace with the time needed
timeout /t 10
REM Enable the ethernet interface, replace "ethernet" with the name of the adapter
netsh interface set interface name="ethernet" admin=enabled >> %logfile%
timeout /t 10
REM Ping to any page and log the response
ping www.google.com >> %logfile%
exit