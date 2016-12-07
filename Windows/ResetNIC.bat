@echo off
goto checkAdmin 

:checkAdmin
net session >nul 2>&1 
if %errorLevel% EQU 0 ( goto Reset )
if %errorLevel% NEQ 0 ( goto ErrorL )

:Reset
mkdir C:\LogRNIC >null
cls
echo ==========================================================
echo == Se requieren permisos administrativos, revisando.... ==
echo ==========================================================
echo .
echo """"""""""""""""""""""""
echo "" Iniciando Reinicio ""
echo """"""""""""""""""""""""
wmic path win32_networkadapter where NetConnectionId="Ethernet" call disable >null
timeout /t 2
wmic path win32_networkadapter where NetConnectionId="Ethernet" call enable >null
echo """"""""""""""""""""""""
echo "" Reinicio terminado ""
echo """"""""""""""""""""""""
echo .
echo Reinicio realiza por: %username% Fecha: %Date% Hora: %time% >> C:\LogRNIC\log_reinicio.log
pause
goto EOF

:ErrorL
mkdir C:\LogRNIC >null
cls
echo %username% no tiene permisos administrativos. Ejecucion Fecha: %date% Hora: %time% >> C:\LogRNIC\log_reinicio.log
echo ==========================================================
echo == Se requieren permisos administrativos, revisando.... ==
echo ==========================================================
echo .
echo .
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo !!!!!  No se tienen permisos, favor de ejecutar como administrador !!!!!!!!
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo .
echo .
pause
exit

:EOF
Exit
