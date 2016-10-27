@echo off 
FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET mydate=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%_%DTS:~8,2%-%DTS:~10,2%-%DTS:~12,2%
goto checkAdmin 

:checkAdmin
echo Se requieren permisos administrativos, revisando....
net session >nul 2>&1 
if %errorLevel% EQU 0 ( goto MAIN )
if %errorLevel% NEQ 0 ( goto ErrorL )
 
:MAIN
REM Disable the ethernet interface, replace "ethernet" with the name of the adapter
wmic path win32_networkadapter where NetConnectionId="Ethernet" call disable > %logfile%
REM Delay time, replace with the time needed
timeout /t 10
REM Enable the ethernet interface, replace "ethernet" with the name of the adapter
wmic path win32_networkadapter where NetConnectionId="Ethernet" call enable >> %logfile%
timeout /t 10
ping www.google.com >> %logfile%
goto EOF

:ErrorL
echo No se tienen permisos administrativos %date%-%time%-%username% > fail_%logfile%.log
echo No se tienen permisos, favor de ejecutar como administrador
pause
exit

:EOF
Exit
