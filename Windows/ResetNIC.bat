@echo off 
FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET mydate=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%_%DTS:~8,2%-%DTS:~10,2%-%DTS:~12,2%
set logfile=log_%mydate%.log
goto checkAdmin 

:checkAdmin
echo ==========================================================
echo == Se requieren permisos administrativos, revisando.... ==
echo ==========================================================
net session >nul 2>&1 
if %errorLevel% EQU 0 ( goto Reset )
if %errorLevel% NEQ 0 ( goto ErrorL )
 
:Reset
echo Reiniciando
ping www.google.com >> %logfile%
timeout /t 10
wmic path win32_networkadapter where NetConnectionId="Ethernet" call disable > %logfile%
timeout /t 10
wmic path win32_networkadapter where NetConnectionId="Ethernet" call enable >> %logfile%
echo """"""""""""""""""""""""
echo "" Reinicio terminado ""
echo """"""""""""""""""""""""
echo Reinicio terminado %mydate% >> %logfile%
timeout /t 5
goto EOF

:ErrorL
echo No se tienen permisos administrativos %date%-%time%-%username% > fail_%mydate%.log
echo .
echo .
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo !!!!!  No se tienen permisos, favor de ejecutar como administrador !!!!!!!!
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo .
timeout /5
exit

:EOF
Exit
