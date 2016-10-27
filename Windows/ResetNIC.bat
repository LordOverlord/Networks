@echo off
Echo Reset de interfaz de red
FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET mydate=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%_%DTS:~8,2%-%DTS:~10,2%-%DTS:~12,2%
pause
goto checkAdmin

:checkAdmin
echo Se requieren permisos administrativos, revisando... 
net session >nul 2>&1 
if %errorLevel% == 0 ( echo Se tienen permisos administrativos ) 
goto MAIN 
else ( echo Tiene que ejecutarse como administrador, saliendo. )
echo No se tienen permisos administrativos : %date%_%time%_%username% > logfail%mydate%.log
goto EOF

:MAIN
REM get the time and date and set for change format
FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET mydate=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%_%DTS:~8,2%-%DTS:~10,2%-%DTS:~12,2%
REM Set the name of the logfile
set logfile=log_%mydate%_%username%.log
REM Disable the ethernet interface, replace "ethernet" with the name of the adapter
wmic path win32_networkadapter where NetConnectionId="Ethernet" call disable >> %logfile%
REM Delay time, replace with the time needed
timeout /t 10
REM Enable the ethernet interface, replace "ethernet" with the name of the adapter
wmic path win32_networkadapter where NetConnectionId="Ethernet" call enable >> %logfile%
timeout /t 10
REM Ping to any page and log the response
ping www.google.com >> %logfile%
goto EOF

:EOF 
exit
